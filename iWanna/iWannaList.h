//
//  iWannaLists.h
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iWannaList : NSObject <NSCoding>//used to save item

@property (nonatomic, copy) NSString *name;//name of item
@property (nonatomic, strong) NSMutableArray *items;//list of items
@property (nonatomic, copy) NSString *iconName;//icon of item
- (int)countUncheckedItems;//gets number of unchecked items


@end
