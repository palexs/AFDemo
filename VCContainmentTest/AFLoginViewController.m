#import "AFLoginViewController.h"
#import "AFDashboardViewController.h"

@interface AFLoginViewController ()

@end

@implementation AFLoginViewController

@synthesize cellPassword, cellLogin;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    loginLabel.text = NSLocalizedString(@"Login: ", @"");
    passwordLabel .text = NSLocalizedString(@"Password: ", @"");
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 186.0f, 42.0f)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImage *image = [UIImage imageNamed:@"bar_logo.png"];
    [imageView setImage:image];
    self.navigationItem.titleView = imageView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [loginTextField setText:@""];
    [passwordTextField setText:@""];
    
    /*
    CGFloat tableBorderLeft = 180;
    CGFloat tableBorderRight = 180;
    
    CGRect tableRect = self.view.frame;
    tableRect.origin.x += tableBorderLeft; // make the table begin a few pixels right from its origin
    tableRect.size.width -= tableBorderLeft + tableBorderRight; // reduce the width of the table
    self.tableView.frame = tableRect;
     */
}

- (void)viewDidAppear:(BOOL)animated
{
    [loginTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.cellLogin = nil;
    self.cellPassword = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIDeviceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)login:(id)sender
{
    if (sender == loginTextField) {
        [passwordTextField becomeFirstResponder];
        return;
    }

    [self performSegueWithIdentifier:@"LoginToDashboardSegue" sender:self];
    //AFDashboardViewController *dashboardVC = [[AFDashboardViewController alloc] init];
    //[self.navigationController pushViewController:dashboardVC animated:YES];
}

- (void)hideKeyboard:(id)sender
{
    [loginTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return NSLocalizedString(@"Please login with your username and password to continue",@"");
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	return NSLocalizedString(@"if you experience issues with login, please contact support service",@"");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) return cellLogin;
    return cellPassword;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
