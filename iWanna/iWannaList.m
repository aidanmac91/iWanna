//
//  iWannaLists.m
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "iWannaList.h"
#import "iWannaItem.h"

@implementation iWannaList
- (id)init
{
    if ((self = [super init]))
    {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];//setups items array
        self.iconName = @"No Icon";//no icon on default
    }
    return self;
}


/*
 reads lists from plist
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.name = [aDecoder decodeObjectForKey:@"Name"];//sets name
        self.items = [aDecoder decodeObjectForKey:@"Items"];//sets items for list
        self.iconName = [aDecoder decodeObjectForKey:@"IconName"];//sets icon
    }
    return self;
}

/*
 saves to plist
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];//save name
    [aCoder encodeObject:self.items forKey:@"Items"];//saves list
    [aCoder encodeObject:self.iconName forKey:@"IconName"];//saves icon
}


/*
 returns number of undone items
 */
- (int)countUncheckedItems
{
    int count = 0;
    for (iWannaItem *item in self.items)//loops through items in the list
    {
        if (!item.checked)//done
        {
            count += 1;//increment
        }
    }
    return count;
}

/*
 compares two lists
 */
- (NSComparisonResult)compare:(iWannaList *)otherChecklist
{
    return [self.name localizedStandardCompare: otherChecklist.name];
}



@end
