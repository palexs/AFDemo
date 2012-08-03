#import <UIKit/UIKit.h>

@interface AFWidgetViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *viewsArray;

- (IBAction)changePage:(id)sender;

- (void)previousPage;
- (void)nextPage;

@end
