//
//  ChatCellMe.m
//  obcChat
//
//  Created by YangYang on 2016-10-07.
//  Copyright © 2016 YangYang. All rights reserved.
//

#import "ChatCellMe.h"

@implementation ChatCellMe

@synthesize message = _message;
@synthesize profileImage = _profileImage;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
