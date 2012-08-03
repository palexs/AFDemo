#import <UIKit/UIKit.h>

@interface AFDashboardViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIView *portfolioView;
@property (nonatomic,strong) IBOutlet UIView *fundsView;
@property (nonatomic,strong) IBOutlet UIView *openTradesView;
@property (nonatomic,strong) IBOutlet UIView *analysisView;

- (IBAction)clickSettings:(id)sender;
- (IBAction)clickLogout:(id)sender;

@end
