//
//  DataModel.m
//  iWanna
//
//  Created by Aidan on 02/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

/*
 first time the app is loaded
 */
- (void)handleFirstTime
{
    BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];//sees if it is the first time
    if (firstTime)//if is then preload
    {
        iWannaList *checklist = [[iWannaList alloc] init];//initialises
        iWannaList *checklist1 = [[iWannaList alloc] init];//initialises
        iWannaList *checklist2= [[iWannaList alloc] init];//initialises
        iWannaList *checklist3 = [[iWannaList alloc] init];//initialises
        //adds list 1
        checklist.name = @"Books";
        checklist.iconName=@"Folder";
        [self.lists addObject:checklist];
        [self setIndexOfSelectediWannalist:0];
        //add list 2
        checklist1.name = @"Films";
        checklist1.iconName=@"Folder";
        [self.lists addObject:checklist1];
        [self setIndexOfSelectediWannalist:1];
        //add list 3
        checklist2.name = @"To Do";
        checklist2.iconName=@"Folder";
        [self.lists addObject:checklist2];
        [self setIndexOfSelectediWannalist:2];
        //add list 4
        checklist3.name = @"Shopping";
        checklist3.iconName=@"Folder";
        [self.lists addObject:checklist3];
        [self setIndexOfSelectediWannalist:3];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];//sets FirstTime to false
        
    }
}


- (id)init {
    if ((self = [super init]))
    {
        [self loadiWannaLists];//loads lists
        [self registerDefaults];//
        [self handleFirstTime];//sees if its first time running

    }
    return self;
}


/*
 This creates a new NSDictionary object and adds the value -1 for the key “ChecklistIndex”.
 NSUserDefaults will use the values from this dictionary if you ask it for a key but it cannot find anything under that key.
 */
- (void)registerDefaults {
    NSDictionary *dictionary = @{
                                 @"ChecklistIndex" : @-1,
                                 @"FirstTime" : @YES,
                                 @"ChecklistItemId" : @0
                                 };
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

/*
 gets index of checklist
 */
- (NSInteger)indexOfSelectedChecklist
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}

/*
 sets index of iwannaList
 */
- (void)setIndexOfSelectediWannalist:(NSInteger)index
{
    [[NSUserDefaults standardUserDefaults]
     setInteger:index forKey:@"ChecklistIndex"];
}

/*
 gets path of plist
 */
- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

/*
 sets iWanna.plist to path
 */
- (NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"iWanna.plist"];
}

/*
save to plist
 */
- (void)saveiWannaLists
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_lists forKey:@"iWannaLists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

/*
 load from plist
 */
- (void)loadiWannaLists
{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])//path exist load from plist
    {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        _lists = [unarchiver decodeObjectForKey:@"iWannaLists"];
        [unarchiver finishDecoding];
    }
    else//else create list
    {
            _lists = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

/*
 calls compare to sort alphabetaically
 */
- (void)sortiWannaLists
{
    [self.lists sortUsingSelector:@selector(compare:)];
}

/*
 gets id of the next item
 */
+(int)nextiWannaItemId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    long itemId = [userDefaults integerForKey:@"ChecklistItemId"];
    [userDefaults setInteger:itemId + 1 forKey:@"ChecklistItemId"];
    [userDefaults synchronize];
    return (int)itemId;
}

/*
 gets the current number of alerts and displays if more than zero
 */
-(void)getBadgeNumber
{
    NSArray *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    int numberOfNots=0;
    
    for (UILocalNotification *notification in allNotifications)//loops through all notifications
    {
        
        NSDate *currentDate = [[NSDate alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *localDateString = [dateFormatter stringFromDate:currentDate];
        NSString *test=notification.fireDate.description;
        NSRange stringRange = {0, MIN([test length], 10)};
        
        // adjust the range to include dependent chars
        stringRange = [test rangeOfComposedCharacterSequencesForRange:stringRange];
        
        // Now you can create the short string
        NSString *shortString = [test substringWithRange:stringRange];
       
        
        if ([shortString isEqualToString:localDateString])
        {
            numberOfNots++;
        }
        
    }
    if(numberOfNots>0)
    {
        [UIApplication sharedApplication].applicationIconBadgeNumber = numberOfNots;
    }
    else
    {
        [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    }
    
}

@end
