//
//  chatView.h
//  obcChat
//
//  Created by YangYang on 2016-10-06.
//  Copyright © 2016 YangYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chatView : UIViewController <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *messageTable;
@property (weak, nonatomic) IBOutlet UITextField *inputMessage;


@end
