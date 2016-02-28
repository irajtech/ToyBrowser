//
//  KnomeTimelineCell.m
//  Knome
//
//  Created by Raj on 23/09/12.
//  Copyright (c) 2012 TCS. All rights reserved.
//

#import "TimelineCell.h"

@implementation TimelineCell
@synthesize avatar = _avatar;
@synthesize postTitle = _postTitle;
@synthesize postDescription = _postDescription;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"TimelineCell" owner:nil options:nil];
		self = [nibArray objectAtIndex:0];
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
  
	// Configure the view for the selected state
}

- (void)layoutSubviews {
	[super layoutSubviews];
	//self.avatar.frame = CGRectMake(4,4,48,48);
  self.avatar.autoresizingMask = UIViewAutoresizingNone;
  self.avatar.layer.cornerRadius = 24.0;
  self.avatar.layer.masksToBounds = YES;
}

@end
