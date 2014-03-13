//
//  DataModel.h
//  iWanna
//
//  Created by Aidan on 02/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iWannaList.h"

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;//arrays of lists

- (void)saveiWannaLists;//saves lists

- (NSInteger)indexOfSelectedChecklist;//gets index of list

- (void)setIndexOfSelectediWannalist:(NSInteger)index;//sets index of list

-(void)sortiWannaLists;//alphabetically

+(NSInteger)nextiWannaItemId;//class method for getting the next list id
-(void)getBadgeNumber;//gets the badge icon number
@end