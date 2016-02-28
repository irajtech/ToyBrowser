//
//  KnomeTimelineCell.h
//  Knome
//
//  Created by Raj on 23/09/12.
//  Copyright (c) 2012 TCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TimelineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *postTitle;
@property (weak, nonatomic) IBOutlet UILabel *postDescription;

@end
