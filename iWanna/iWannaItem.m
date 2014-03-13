//
//  iWannaItem.m
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "iWannaItem.h"

@implementation iWannaItem

/*
 toggles between active/inactive
 */
- (void)toggleChecked {
    self.checked = !self.checked;
}

/*
 saves to plist
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInteger:self.itemId forKey:@"ItemID"];
    [aCoder encodeObject:self.priority forKey:@"Priority"];
}

/*
 reads from plist
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntegerForKey:@"ItemID"];
        self.priority=[aDecoder decodeObjectForKey:@"Priority"];
    }
    return self;
}

/*
 
 */
- (id)init {
    if (self = [super init]) {
        self.itemId = [DataModel nextiWannaItemId];
    }
    return self; }

/*
 setups notification
 */
- (void)scheduleNotification {
    
        UILocalNotification *existingNotification = [self notificationForThisItem];
        if (existingNotification != nil)//if there is existing notification
        {
            [[UIApplication sharedApplication]cancelLocalNotification:existingNotification];//cancel
        }
    
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending)//if shouldRemind = true and due date is in the future
    {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];//inits notification
        localNotification.fireDate = self.dueDate;//when notification is called
        localNotification.timeZone = [NSTimeZone defaultTimeZone]; localNotification.alertBody = self.text;//text of notification
        localNotification.soundName =UILocalNotificationDefaultSoundName;//sets sounds
        localNotification.userInfo = @{@"ItemID" : @(self.itemId) };//what item called it
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    

}

/*
 gets the existing notifications
 */
- (UILocalNotification *)notificationForThisItem
{
    NSArray *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (UILocalNotification *notification in allNotifications)//loops through all notifications
    {
        NSNumber *number = [notification.userInfo objectForKey:@"ItemID"];
        
        if (number != nil && [number integerValue] == self.itemId)//if there is a notification for the item already
        {
            return notification;
        }
    }
    return nil;//no notification
}


/*
 used to release resource by the notification
 */
- (void)dealloc {
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if (existingNotification != nil) {
        [[UIApplication sharedApplication]cancelLocalNotification:existingNotification];//removes the existing notification 
    }
}
@end
