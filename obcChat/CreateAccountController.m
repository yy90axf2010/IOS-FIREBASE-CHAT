//
//  CreateAccountController.m
//  obcChat
//
//  Created by YangYang on 2016-10-06.
//  Copyright © 2016 YangYang. All rights reserved.
//

#import "CreateAccountController.h"
@import Firebase;

@interface CreateAccountController ()
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation CreateAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createPressed:(id)sender {
    [[FIRAuth auth] createUserWithEmail:[self.emailText text] password:[self.passwordText text] completion:^(FIRUser *user, NSError *error){
        if(error==nil){
            [self uploadAccountInfo];
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", @"ok action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            [alert addAction:alertAction];
        }
    }];
}

- (IBAction)choosePhotoPressed:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageProfile.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void) uploadAccountInfo{
    FIRUser *user = [FIRAuth auth].currentUser;
    FIRUserProfileChangeRequest *changeRequest = [user profileChangeRequest];
    
    changeRequest.displayName = [_usernameText text];
    // Points to the root reference
    FIRStorageReference *storageRef = [[FIRStorage storage] referenceForURL:@"gs://obcchat-525bf.appspot.com/"];
    NSString *path = [@"images/" stringByAppendingString:[FIRAuth auth].currentUser.uid];
    NSData *data = UIImageJPEGRepresentation(_imageProfile.image, 0.8);
    FIRStorageReference *profileREF = [storageRef child:(path)];
    
    FIRStorageUploadTask *uploadTask = [profileREF putData:data metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
        if (error != nil) {
            // Uh-oh, an error occurred!
        } else {
            // Metadata contains file metadata such as size, content-type, and download URL.
            NSURL *downloadURL = metadata.downloadURL;
            changeRequest.photoURL = downloadURL;
            [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
                if (error) {
                    // An error happened.
                } else {
                    self.ref = [[FIRDatabase database] reference];
                    [[[_ref child:@"UserPools"] child:user.uid]
                     setValue:@{@"username": [FIRAuth auth].currentUser.displayName,
                                @"uid": [FIRAuth auth].currentUser.uid,
                                @"photoURL": [FIRAuth auth].currentUser.photoURL.absoluteString,
                                @"email": [FIRAuth auth].currentUser.email}];
                }
            }];
        }
    }];
    
}

@end
