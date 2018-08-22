//
//  WorkView.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 02.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkView : UIView
@property (weak, nonatomic) IBOutlet UILabel *mondayHolyday;
@property (weak, nonatomic) IBOutlet UILabel *mondayTime;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property (weak, nonatomic) IBOutlet UILabel *thusdayHolyday;
@property (weak, nonatomic) IBOutlet UILabel *thusdayTime;


@property (weak, nonatomic) IBOutlet UILabel *wedneyHolyday;
@property (weak, nonatomic) IBOutlet UILabel *wedneyTime;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;


@property (weak, nonatomic) IBOutlet UILabel *thurdsHolyday;
@property (weak, nonatomic) IBOutlet UILabel *thurdsTime;

@property (weak, nonatomic) IBOutlet UILabel *friHolyday;
@property (weak, nonatomic) IBOutlet UILabel *friTime;

@property (weak, nonatomic) IBOutlet UILabel *saturHolyday;
@property (weak, nonatomic) IBOutlet UILabel *saturTime;

@property (weak, nonatomic) IBOutlet UILabel *sunHolyday;
@property (weak, nonatomic) IBOutlet UILabel *sunTime;

@property NSArray *labels;
@property NSArray *holidays;
@property NSArray *days;
@end
