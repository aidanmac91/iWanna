//
//  iWannaItem.h
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface iWannaItem : NSObject <NSCoding>
@property (nonatomic,copy)NSString *text;//name
@property (nonatomic,assign) bool checked;//toggle for checked
@property (nonatomic, copy) NSDate *dueDate;//date
@property (nonatomic, copy) NSString *priority;//low/medium/high
@property (nonatomic, assign) BOOL shouldRemind;//toggle for reminder
@property (nonatomic, assign) NSInteger itemId;//unique id
- (void)toggleChecked;//toggles between active/inactive
- (void)scheduleNotification;//notifys user of event
@end
