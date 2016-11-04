//
//  TVOPickerDate.h
//
//  Created by Thanhln 7/22/2013.
//  Copyright (c) 2013 TinhVan Outsourcing JSC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MISE_DATETIME_TYPE) {
    MISE_DATETIME_TYPE_ANONYMOUS,
    MISE_DATETIME_TYPE_FREE,
    MISE_DATETIME_TYPE_PASSED,
    MISE_DATETIME_TYPE_FUTURE
};
typedef NS_ENUM(NSInteger, MISE_PROCESS_DATE_TYPE) {
    MISE_PROCESS_DATE_TYPE_ADD,
    MISE_PROCESS_DATE_TYPE_EDIT
};
@protocol TVOPickerDateDelegate
//- (void)updateDateTime:(NSDate *)date;
@optional
- (void)updateDateTime:(NSDate *)date withType: (MISE_PROCESS_DATE_TYPE) type;
- (void) deleteRecord;
@end
@interface TVOPickerDate : NSObject
{
    UIActionSheet* actionSheet;
    UIDatePicker *datePicker;
    MISE_DATETIME_TYPE dateType;
    MISE_PROCESS_DATE_TYPE processType;
}

@property (assign, nonatomic) NSObject<TVOPickerDateDelegate> *delegate;
- (void)resetPicker;
- (void)presentDatePicker: (MISE_DATETIME_TYPE) type withProcess: (MISE_PROCESS_DATE_TYPE) process_type;
- (void)dismissActionSheet: (UISegmentedControl*) sender;
- (void)setDefaultDate:(NSDate *)date;
@end
