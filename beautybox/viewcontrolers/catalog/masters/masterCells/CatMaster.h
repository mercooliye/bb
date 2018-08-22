//
//  CatMaster.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 07.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatMaster : UIView
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property float summ;
@property int count;
@end
