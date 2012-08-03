#import <UIKit/UIKit.h>

@interface AFLoginViewController : UITableViewController
{
    IBOutlet UITextField* loginTextField;
    IBOutlet UITextField* passwordTextField;

    IBOutlet UILabel* loginLabel;
    IBOutlet UILabel* passwordLabel;
}

-(IBAction) login:(id)sender;
-(void)hideKeyboard:(id)sender;

@property (nonatomic, retain) IBOutlet UITableViewCell* cellLogin;
@property (nonatomic, retain) IBOutlet UITableViewCell* cellPassword;


@end
