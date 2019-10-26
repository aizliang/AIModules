//
//  AIContact.m
//  湾湾钱包
//
//  Created by ai on 2019/10/26.
//  Copyright © 2019 wind. All rights reserved.
//

#import "AIContact.h"
#import "AIHierarchyTool.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface AIContact ()<CNContactPickerDelegate>
@property (nonatomic,strong) WWSelectLinkManCompletion completion;
@end

@implementation AIContact
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static AIContact *contact;
    dispatch_once(&onceToken, ^{
        contact = [[AIContact alloc] init];
    });
    
    return contact;
}

- (void)showContactWithCompletion:(WWSelectLinkManCompletion)completion {
    self.completion = completion;
    
    CNContactPickerViewController *pickController = [CNContactPickerViewController new];
    pickController.delegate = self;
    [[AIHierarchyTool getTopViewController] presentViewController:pickController animated:YES completion:nil];
}

#pragma mark - CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    
    NSArray<CNLabeledValue<CNPhoneNumber*>*> *phoneNumbers = contact.phoneNumbers;
    if (phoneNumbers.count == 0) {
        return;
    }
    
    NSString *phoneNum = phoneNumbers.firstObject.value.stringValue;
    NSDictionary *linkManInfo = @{@"name": [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName],
                                  @"phoneNum": phoneNum ? : @""};
    _completion(linkManInfo);
}

@end
