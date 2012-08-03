#import "AFFundsViewController.h"

@interface AFFundsViewController ()

@end

@implementation AFFundsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"FundsViewOne" owner:self options:nil];
    UIView *one = [nibObjects objectAtIndex:0];
    
    nibObjects = [[NSBundle mainBundle] loadNibNamed:@"FundsViewTwo" owner:self options:nil];
    UIView *two = [nibObjects objectAtIndex:0];
    
    NSArray *views = [NSArray arrayWithObjects:one, two, nil];
    self.viewsArray = views;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
