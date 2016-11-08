//
//  TVOPickerDate.m
//  DemoComboBox
//
//  Created by Thanhln 7/22/2013.
//  Copyright (c) 2013 TinhVan Outsourcing JSC. All rights reserved.
//

#import "TVOPickerDate.h"


@interface TVOPickerDate ()
{
    NSDate *defaultDate;
    UIView *pickerView;
    UIView *viewBG ;
}
@end
@implementation TVOPickerDate


- (void)presentDatePicker:(MISE_DATETIME_TYPE)type withProcess:(MISE_PROCESS_DATE_TYPE)process_type{
    dateType = type;
    processType = process_type;
    if (!actionSheet) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        
        [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    }
    [self resetPicker];
    [actionSheet addSubview:datePicker];
    
    NSArray *listButton = nil;
    switch (process_type) {
        case MISE_PROCESS_DATE_TYPE_ADD:
            listButton = @[@"設定",@"キャンセル"];
            break;
            
        case MISE_PROCESS_DATE_TYPE_EDIT:
            listButton = @[@"更新",@"キャンセル",@"削除"];
            break;
            
        default:
            break;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        viewBG = [[UIView alloc] init];
        CGRect viewBGframe = [[UIApplication sharedApplication] keyWindow].frame;
        viewBG.frame   = viewBGframe;
        viewBG.backgroundColor = [UIColor grayColor];
        viewBG.alpha = 0.5;
        [[[UIApplication sharedApplication] keyWindow] addSubview:viewBG];
        pickerView = [[UIView alloc] init];
        pickerView.frame  = CGRectMake(0, 0, 320, 480);
        pickerView.backgroundColor = [UIColor greenColor];
        UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:listButton];
        closeButton.momentary = YES;
        closeButton.frame = CGRectMake(10, 7.0f, 220.0f, 30.0f);
        //意味ないのでコメント
        //closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
        closeButton.tintColor = [UIColor blackColor];
        [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
         if (!pickerView) {
            pickerView = [[UIView alloc] initWithFrame:datePicker.frame];
        } else {
            [pickerView setHidden:NO];
        }
        CGFloat pickerViewYpositionHidden = [[UIApplication sharedApplication] keyWindow].frame.size.height + pickerView.frame.size.height;
        CGFloat pickerViewYposition = [[UIApplication sharedApplication] keyWindow].frame.size.height - pickerView.frame.size.height/2;
        [pickerView setFrame:CGRectMake(pickerView.frame.origin.x,
                                        pickerViewYpositionHidden,
                                        pickerView.frame.size.width,
                                        pickerView.frame.size.height)];
        [pickerView setBackgroundColor:[UIColor whiteColor]];
        [pickerView addSubview:closeButton];
        [pickerView addSubview:datePicker];
        [datePicker setHidden:NO];
        [[[UIApplication sharedApplication] keyWindow] addSubview:pickerView];
        
        [UIView animateWithDuration:0.5f
                         animations:^{
                             [pickerView setFrame:CGRectMake(pickerView.frame.origin.x,
                                                             pickerViewYposition,
                                                             pickerView.frame.size.width,
                                                             pickerView.frame.size.height)];
                         }
                         completion:nil];
        [viewBG bringSubviewToFront:pickerView];
        
    } else {
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:listButton];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(10, 7.0f, 220.0f, 30.0f);
    //意味無いのでコメント
    //closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    }
}
- (void)changeDate:(UIDatePicker *)picker{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateDateTime:withType:)]) {
        [self.delegate updateDateTime:picker.date withType:processType];
    }
}
- (void)dismissActionSheet: (UISegmentedControl*) sender
{
    if (sender.selectedSegmentIndex == 0) {
        [self changeDate:datePicker];
    }else if(sender.selectedSegmentIndex == 2){
        [self.delegate deleteRecord];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        [viewBG removeFromSuperview];
        CGFloat pickerViewYpositionHidden = [[UIApplication sharedApplication] keyWindow].frame.size.height + pickerView.frame.size.height;
        [UIView animateWithDuration:0.5f
                         animations:^{
                             [pickerView setFrame:CGRectMake(pickerView.frame.origin.x,
                                                             pickerViewYpositionHidden,
                                                             pickerView.frame.size.width,
                                                             pickerView.frame.size.height)];
                         }
                         completion:nil];
    } else {
        [actionSheet dismissWithClickedButtonIndex:0 animated:NO];
        [sender removeFromSuperview];
    }
}
- (void)resetPicker{
    if (!datePicker) {
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 450)];
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        
        switch (dateType) {
            case MISE_DATETIME_TYPE_ANONYMOUS:
                datePicker.datePickerMode = UIDatePickerModeDate;
                break;
            
            case MISE_DATETIME_TYPE_FREE:
                
                break;
                
            case MISE_DATETIME_TYPE_PASSED:
                datePicker.minimumDate = [NSDate date];
                break;
                
            case MISE_DATETIME_TYPE_FUTURE:
                datePicker.maximumDate = [NSDate date];
                break;
            default:
                break;
        }
        
        
//        datePicker.timeZone = [NSTimeZone systemTimeZone];
       // datePicker.maximumDate = [NSDate date];
       // datePicker.minuteInterval = 30;
       // [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    }
    if (!defaultDate) {
        defaultDate = [NSDate date];
    }
    [datePicker setDate:defaultDate animated:YES];
}
- (void)setDefaultDate:(NSDate *)date{
    defaultDate = date;
    [self resetPicker];
}
@end
