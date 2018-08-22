//
//  WorkView.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 02.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "WorkView.h"

@implementation WorkView

- (void)awakeFromNib
{
    self.todayLabel.layer.cornerRadius=4.0f;
    self.todayLabel.layer.masksToBounds=YES;
   self.labels=@[self.mondayTime,
                 self.thusdayTime,
                 self.wedneyTime,
                 self.thurdsTime,
                 self.friTime,
                 self.saturTime,
                 self.sunTime];
    
    
    self.holidays=@[self.mondayHolyday,
                  self.thusdayHolyday,
                  self.wedneyHolyday,
                  self.thurdsHolyday,
                  self.friHolyday,
                  self.saturHolyday,
                  self.sunHolyday];
    
    self.days=@[@"monday",
                @"tuesday",
                @"wednesday",
                @"thursday",
                @"friday",
                @"saturday",
                @"sunday"];
    [super awakeFromNib];

}


@end
