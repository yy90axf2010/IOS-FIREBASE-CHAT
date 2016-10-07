//
//  chatView.m
//  obcChat
//
//  Created by YangYang on 2016-10-06.
//  Copyright © 2016 YangYang. All rights reserved.
//

#import "chatView.h"
#import "ChatCellMe.h"
#import "ChatCellYou.h"

@import Firebase;
@interface chatView ()
@property (strong,nonatomic) FIRDatabaseReference *rootREF;

@end

@implementation chatView

{
    BOOL *you;
}

@synthesize inputMessage = _inputMessage;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //register cell
    [self.messageTable registerNib:[UINib nibWithNibName:NSStringFromClass([ChatCellMe class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ChatCellMe class])];
    [self.messageTable registerNib:[UINib nibWithNibName:NSStringFromClass([ChatCellYou class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ChatCellYou class])];
    
    NSLog(@"%@",[FIRAuth auth].currentUser.displayName);
    NSLog(@"%@",[FIRAuth auth].currentUser.uid);
    NSLog(@"%@",[FIRAuth auth].currentUser.email);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *friendsCell = @"myCell";
//    myCell *cell = [tableView dequeueReusableCellWithIdentifier:friendsCell];
//    
//    
//    cell.userName.text = [name objectAtIndex:indexPath.row];
//    cell.userEmail.text = [email objectAtIndex:indexPath.row];
//    cell.userimage.image = [UIImage imageNamed:[url objectAtIndex:indexPath.row]];
    static NSString *messageCell;
    ChatCellYou *cell;
    if (you) {
        static NSString *messageCell = @"ChatCellYou";
        ChatCellYou *cell = [tableView dequeueReusableCellWithIdentifier:messageCell];
    }else{
        static NSString *messageCell = @"ChatCellMe";
        ChatCellMe *cell = [tableView dequeueReusableCellWithIdentifier:messageCell];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (IBAction)sendPredded:(id)sender {
    self.rootREF = [[FIRDatabase database] reference];
    
    NSLog(@"%@",self.inputMessage.text);
    NSString *message = self.inputMessage.text;
    
    [[[_rootREF child:@"Message"] child:[FIRAuth auth].currentUser.uid]
     setValue:@{@"From": [FIRAuth auth].currentUser.displayName,
                @"To": @"target User BOX",
                @"Message": message}];
    
    
    //self.inputMessage.text = nil;
}

@end
