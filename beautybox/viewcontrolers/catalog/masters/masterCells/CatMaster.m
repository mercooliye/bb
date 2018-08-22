//
//  CatMaster.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 07.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "CatMaster.h"

@implementation CatMaster

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numberLabel.layer.cornerRadius=self.numberLabel.frame.size.width/2;
    self.numberLabel.layer.masksToBounds=YES;
    // Initialization code
}


@end
