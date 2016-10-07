//
//  myCell.h
//  obcChat
//
//  Created by YangYang on 2016-10-06.
//  Copyright © 2016 YangYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;

@end
