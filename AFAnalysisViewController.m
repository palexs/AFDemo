#import "AFAnalysisViewController.h"

@interface AFAnalysisViewController ()

@end

@implementation AFAnalysisViewController

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
	
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"AnalysisViewOne" owner:self options:nil];
    UIView *one = [nibObjects objectAtIndex:0];
    
    NSArray *views = [NSArray arrayWithObjects:one, nil];
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
