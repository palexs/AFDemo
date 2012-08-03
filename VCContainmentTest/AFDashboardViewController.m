#import "AFDashboardViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AFPortfolioViewController.h"
#import "AFFundsViewController.h"
#import "AFOpenTradesViewController.h"
#import "AFAnalysisViewController.h"

@interface AFDashboardViewController ()

@property (nonatomic, strong) AFPortfolioViewController *portfolioVC;
@property (nonatomic, strong) AFFundsViewController *fundsVC;
@property (nonatomic, strong) AFOpenTradesViewController *openTradesVC;
@property (nonatomic, strong) AFAnalysisViewController *analysisVC;

- (void)setupPlaceholderViews;
- (void)handleTap:(UITapGestureRecognizer*)tap;

@end

@implementation AFDashboardViewController

@synthesize portfolioView, fundsView, openTradesView, analysisView;
@synthesize portfolioVC, fundsVC, openTradesVC, analysisVC;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad_background.png"]];
    
    self.portfolioVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PortfolioViewController"];
    self.fundsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FundsViewController"];
    self.openTradesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenTradesViewController"];
    self.analysisVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AnalysisViewController"];
    
    [self setupPlaceholderViews];
    
    UITapGestureRecognizer *gestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    gestureRecogniser.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gestureRecogniser];
}

- (void)setupPlaceholderViews
{
    self.portfolioVC.view.frame = self.portfolioView.bounds;
    self.portfolioView.layer.cornerRadius = 15.0;
    self.portfolioView.layer.masksToBounds = YES;
    self.portfolioView.layer.shadowOffset = CGSizeMake(-15, 20);
    self.portfolioView.layer.shadowRadius = 5;
    self.portfolioView.layer.shadowOpacity = 1;
    
    [self.portfolioView addSubview:portfolioVC.view];
    [self.portfolioVC didMoveToParentViewController:self];
    [self addChildViewController:portfolioVC];
    
    self.fundsVC.view.frame = self.fundsView.bounds;
    self.fundsView.layer.cornerRadius = 15.0;
    self.fundsView.layer.masksToBounds = YES;
    self.fundsView.layer.shadowOffset = CGSizeMake(-15, 20);
    self.fundsView.layer.shadowRadius = 5;
    self.fundsView.layer.shadowOpacity = 1;
    
    [self.fundsView addSubview:fundsVC.view];
    [self.fundsVC didMoveToParentViewController:self];
    [self addChildViewController:fundsVC];
    
    self.openTradesVC.view.frame = self.openTradesView.bounds;
    self.openTradesView.layer.cornerRadius = 15.0;
    self.openTradesView.layer.masksToBounds = YES;
    self.openTradesView.layer.shadowOffset = CGSizeMake(-15, 20);
    self.openTradesView.layer.shadowRadius = 5;
    self.openTradesView.layer.shadowOpacity = 1;
    
    [self.openTradesView addSubview:openTradesVC.view];
    [self.openTradesVC didMoveToParentViewController:self];
    [self addChildViewController:openTradesVC];
    
    self.analysisVC.view.frame = self.analysisView.bounds;
    self.analysisView.layer.cornerRadius = 15.0;
    self.analysisView.layer.masksToBounds = YES;
    self.analysisView.layer.shadowOffset = CGSizeMake(-15, 20);
    self.analysisView.layer.shadowRadius = 5;
    self.analysisView.layer.shadowOpacity = 1;
    
    [self.analysisView addSubview:analysisVC.view];
    [self.analysisVC didMoveToParentViewController:self];
    [self addChildViewController:analysisVC];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.portfolioView = nil;
    self.fundsView = nil;
    self.openTradesView = nil;
    self.analysisView = nil;
    self.portfolioVC = nil;
    self.fundsVC = nil;
    self.openTradesVC = nil;
    self.analysisVC = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIDeviceOrientationIsLandscape(interfaceOrientation);
}

- (void)handleTap:(UITapGestureRecognizer*)tap {
    CGPoint point = [tap locationInView:self.view];
    
    if (CGRectContainsPoint(self.portfolioView.frame, point)) {
        [self performSegueWithIdentifier:@"DashboardToPortfolioDetails" sender:self];
    } else if (CGRectContainsPoint(self.fundsView.frame, point)) {
        [self performSegueWithIdentifier:@"DashboardToFundsDetails" sender:self];
    } else if (CGRectContainsPoint(self.openTradesView.frame, point)) {
        [self performSegueWithIdentifier:@"DashboardToOpenTradesDetails" sender:self];
    } else if (CGRectContainsPoint(self.analysisView.frame, point)) {
        [self performSegueWithIdentifier:@"DashboardToAnalysisDetails" sender:self];
    } else {
        NSLog(@"*** Unknown view region tapped.");
        return;
    }
}

- (IBAction)clickSettings:(id)sender {
    
}

- (IBAction)clickLogout:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
