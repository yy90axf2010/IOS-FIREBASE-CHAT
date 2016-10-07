//
//  FriendsListViewController.m
//  obcChat
//
//  Created by YangYang on 2016-10-06.
//  Copyright © 2016 YangYang. All rights reserved.
//

#import "FriendsListViewController.h"
#import "myCell.h"

@interface FriendsListViewController ()

@end

@implementation FriendsListViewController

{
    NSArray *name;
    NSArray *email;
    NSArray *url;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    name = [NSArray arrayWithObjects:@"Yang",@"AN",@"Chik",nil];
    email = [NSArray arrayWithObjects:@"email1",@"email2",@"email3",nil];
    url = [NSArray arrayWithObjects:@"profile.png",@"profile.png",@"profile.png",nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([myCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([myCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [name count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *friendsCell = @"myCell";
    myCell *cell = [tableView dequeueReusableCellWithIdentifier:friendsCell];
    

    cell.userName.text = [name objectAtIndex:indexPath.row];
    cell.userEmail.text = [email objectAtIndex:indexPath.row];
    cell.userimage.image = [UIImage imageNamed:[url objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%@", self.data[indexPath.row]);
    // init view controller
    UIViewController *nextViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"chatView"];
    //push to navigation controller
    [self.navigationController pushViewController:nextViewController animated:YES];
    // modal view
//    [self presentViewController:nextViewController animated:YES completion:^{
//        // complete
//    }];
}

@end
