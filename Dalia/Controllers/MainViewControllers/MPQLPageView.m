//
//  MPQLPageView.m
//  objc
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPQLPageView.h"

@interface MPQLPageView () <UIScrollViewDelegate>

// Currently selected page index
@property (nonatomic, readwrite) NSInteger selectedIndex;

// Scroll view containing the views of the pages
@property (nonatomic, strong) UIScrollView *containerScrollView;
// View containing the buttons of the pages
@property (nonatomic, strong) UIView *buttonBar;
// Circle used to indicate selected page
@property (nonatomic, strong) UIView *selectionIndicator;

// Array that keeps hold of all buttons
@property (nonatomic, strong) NSArray *buttons;
// Array that keeps hold of all labels
@property (nonatomic, strong) NSArray *labels;

@end

@implementation MPQLPageView
{
    CGFloat gapV;
    CGFloat gapH;
    CGFloat selectionIndicatorY;
    CGFloat buttonWidth;
    CGFloat labelWidth;
    
    struct {
        bool initialIndexForPageInPageView;
        bool numberOfPagesInPageView;
        bool titleForLabelForPageAtIndex;
        bool selectedIndexForPageView;
    } dataSourceCan;
    
    struct {
        bool heightForButtonBarForPageView;
        bool colorForButtonBarForPageView;
        bool colorForButtonBarSelectionIndicatorForPageView;
        bool onTintColorForControlSwitchForPageView;
        bool fontForButtonsForPageView;
        bool fontForLabelsForPageView;
        bool controlSwitchDidChangeValue;
        bool didMoveToPage;
    } delegateCan;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _pageViewStyle = MPQLPageViewButtonBarStyleDefault;
        _buttonBarHeight = 50.0;
        _buttonBarColor = [UIColor blackColor];
        _switchOnTintColor = [UIColor yellowColor];
        _buttonBarSelectionIndicatorColor = [UIColor whiteColor];
        _buttonFont = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        _labelFont = [UIFont fontWithName:@"Helvetica" size:10.0];
    }
    
    return self;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if (self.superview) {
        [self reloadPageView];
    }
}

- (void)reloadPageView
{
    if (!self.dataSource) {
        return;
    }
    
    if (dataSourceCan.selectedIndexForPageView) {
        self.selectedIndex = [self.dataSource selectedIndexForPageView:self];
    }
    if (dataSourceCan.initialIndexForPageInPageView) {
        self.initialIndex = [self.dataSource initialIndexForPageInPageView:self];
    }
    
    self.selectedIndex = self.initialIndex;
    
    // Remove all subviews
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    [self loadContainerScrollView];
//    [self loadButtonBar];
    
    [self gotoPage:self.selectedIndex animated:NO];
    [self selectButtonAtIndex:self.selectedIndex];
}

- (void)setDataSource:(id<MPQLPageViewDataSource>)dataSource
{
    _dataSource = dataSource;
    
    dataSourceCan.initialIndexForPageInPageView = [self.dataSource respondsToSelector:@selector(initialIndexForPageInPageView:)];
    dataSourceCan.numberOfPagesInPageView = [self.dataSource respondsToSelector:@selector(numberOfPagesInPageView:)];
    dataSourceCan.selectedIndexForPageView = [self.dataSource respondsToSelector:@selector(selectedIndexForPageView:)];
    dataSourceCan.titleForLabelForPageAtIndex = [self.dataSource respondsToSelector:@selector(pageView:titleForLabelForPageAtIndex:)];
}

- (void)setDelegate:(id<MPQLPageViewDelegate>)delegate
{
    _delegate = delegate;
    
    delegateCan.colorForButtonBarForPageView = [self.delegate respondsToSelector:@selector(colorForButtonBarForPageView:)];
    delegateCan.colorForButtonBarSelectionIndicatorForPageView = [self.delegate respondsToSelector:@selector(colorForButtonBarSelectionIndicatorForPageView:)];
    delegateCan.onTintColorForControlSwitchForPageView = [self.delegate respondsToSelector:@selector(onTintColorForControlSwitchForPageView:)];
    delegateCan.controlSwitchDidChangeValue = [self.delegate respondsToSelector:@selector(pageView:controlSwitchDidChangeValue:)];
    delegateCan.didMoveToPage = [self.delegate respondsToSelector:@selector(pageView:didMoveToPage:)];
    delegateCan.fontForButtonsForPageView = [self.delegate respondsToSelector:@selector(fontForButtonsForPageView:)];
    delegateCan.fontForLabelsForPageView = [self.delegate respondsToSelector:@selector(fontForLabelsForPageView:)];
    delegateCan.heightForButtonBarForPageView = [self.delegate respondsToSelector:@selector(heightForButtonBarForPageView:)];
}

#pragma mark - Container Scroll View Methods

- (void)loadContainerScrollView
{
    if (delegateCan.heightForButtonBarForPageView) {
        self.buttonBarHeight = [self.delegate heightForButtonBarForPageView:self];
    }
    if (dataSourceCan.numberOfPagesInPageView) {
        self.numberOfPages = [self.dataSource numberOfPagesInPageView:self];
    }
    
    // Initialize container scroll view
    _containerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [self addSubview:self.containerScrollView];
    
    // Setting the height to 1 will allow only horizontal scrolls
    self.containerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * self.numberOfPages, 1);
    
    self.containerScrollView.delegate = self;
    self.containerScrollView.pagingEnabled = YES;
    self.containerScrollView.showsHorizontalScrollIndicator = NO;
    self.containerScrollView.showsVerticalScrollIndicator = NO;
    self.containerScrollView.directionalLockEnabled = YES;
    self.containerScrollView.bounces = NO;
    
    for (NSInteger i = 0; i < self.numberOfPages ; i++) {
        [self loadPageWithIndex:i];
    }
}

- (void)loadPageWithIndex:(NSInteger)index
{
    // Get the view from the dataSource
    UIView *page = [self.dataSource pageView:self viewForPageAtIndex:index];
    
    // Setup the frame of the page
    CGRect frame = self.containerScrollView.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    page.frame = frame;
    
    [self.containerScrollView addSubview:page];
}

#pragma mark - Button Bar Methods

- (void)loadButtonBar
{
    if (delegateCan.heightForButtonBarForPageView) {
        self.buttonBarHeight = [self.delegate heightForButtonBarForPageView:self];
    }
    if (delegateCan.colorForButtonBarForPageView) {
        self.buttonBarColor = [self.delegate colorForButtonBarForPageView:self];
    }
    
    
    // Initialize button bar
    _buttonBar = [[UIView alloc] initWithFrame:CGRectMake(0, _containerScrollView.frame.size.height-50, self.frame.size.width, self.buttonBarHeight)];
    self.buttonBar.backgroundColor = [UIColor clearColor];
    [self addSubview:self.buttonBar];
    [self bringSubviewToFront:self.buttonBar];
    
    [self loadButtons];
}

- (void)loadButtons
{
    //UIPageControllの作成
    pageControl =  [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.buttonBar.bounds.size.width, 30)];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.numberOfPages = self.numberOfPages;
    pageControl.currentPage = 0;
    [self.buttonBar addSubview:pageControl];
}

#pragma mark - Actions

- (void)selectPage:(UIButton *)sender
{
    NSInteger index = [self.buttons indexOfObject:sender];
    [self gotoPage:index animated:YES];
}

- (void)selectButtonAtIndex:(NSInteger)index
{
    pageControl.currentPage = index;

}

- (void)deselectButtonAtIndex:(NSInteger)index
{

}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    [self deselectButtonAtIndex:self.selectedIndex];
    _selectedIndex = selectedIndex;
    [self selectButtonAtIndex:self.selectedIndex];
}

- (void)gotoPage:(NSInteger)index animated:(BOOL)animated
{
    CGRect bounds = self.containerScrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * index;
    bounds.origin.y = 0;
    [self.containerScrollView scrollRectToVisible:bounds animated:animated];
}

- (void)switchChangedValue:(UISwitch *)sender
{
    if (delegateCan.controlSwitchDidChangeValue) {
        [self.delegate pageView:self controlSwitchDidChangeValue:sender.isOn];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.containerScrollView.frame);
    
    CGFloat contentWidth = self.containerScrollView.contentSize.width - pageWidth;
    
    if (contentWidth != 0) {
        CGFloat scrolledPercentage = self.containerScrollView.contentOffset.x / contentWidth;
        UIButton *lastButton = self.buttons.lastObject;
        UIButton *firstButton = self.buttons.firstObject;
        CGFloat barWidth = lastButton.frame.origin.x - firstButton.frame.origin.x;
        
        CGRect frame = self.selectionIndicator.frame;
        frame.origin.x = firstButton.frame.origin.x + scrolledPercentage * barWidth;
        self.selectionIndicator.frame = frame;
        
        NSInteger index = floor((self.containerScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        if (index != self.selectedIndex) {
            self.selectedIndex = index;
            if (delegateCan.didMoveToPage) {
                [self.delegate pageView:self didMoveToPage:self.selectedIndex];
            }
        }
    }
}

@end
