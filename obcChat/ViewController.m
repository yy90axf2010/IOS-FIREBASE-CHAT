//
//  ViewController.m
//  obcChat
//
//  Created by YangYang on 2016-10-06.
//  Copyright © 2016 YangYang. All rights reserved.
//

#import "ViewController.h"
@import Firebase;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)loginPressed:(id)sender
{
    [[FIRAuth auth] signInWithEmail:[self.emailText text] password:[self.passwordText text] completion:^(FIRUser *user, NSError *error){
        if(error){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", @"ok action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            [alert addAction:alertAction];
            [self presentViewController:alert animated:YES completion:nil];
            NSLog(@"%@",error.localizedDescription);
            
        }else{
            if ([FIRAuth auth].currentUser != nil) {
                UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UINavigationController *controller = [storybord instantiateViewControllerWithIdentifier:@"navi"];
                [self presentViewController:controller animated:YES completion:nil];
            }
        }
    }];
}

- (IBAction)createAccountPressed:(id)sender
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
