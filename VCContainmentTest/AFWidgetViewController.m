#import "AFWidgetViewController.h"

@interface AFWidgetViewController ()

@property (assign) BOOL pageControlUsed;
@property (assign) NSUInteger page;
@property (assign) BOOL rotating;

- (void)loadScrollViewWithPage:(int)page;

@end

@implementation AFWidgetViewController

@synthesize scrollView;
@synthesize pageControl;
@synthesize pageControlUsed = _pageControlUsed;
@synthesize page = _page;
@synthesize rotating = _rotating;
@synthesize viewsArray = _theViews;

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.scrollView setPagingEnabled:YES];
	[self.scrollView setScrollEnabled:YES];
	[self.scrollView setShowsHorizontalScrollIndicator:NO];
	[self.scrollView setShowsVerticalScrollIndicator:NO];
	[self.scrollView setDelegate:self];
    
    [self.view bringSubviewToFront:self.pageControl];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIDeviceOrientationIsLandscape(interfaceOrientation);
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
    for (NSUInteger i = 0; i < [self.viewsArray count]; i++) {
		[self loadScrollViewWithPage:i];
	}
	
    self.pageControl.currentPage = _page;
	[self.pageControl setNumberOfPages:[self.viewsArray count]];
    
    self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [self.viewsArray count], scrollView.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0)
        return;
    if (page >= [self.viewsArray count])
        return;
    
    UIView *view = [self.viewsArray objectAtIndex:page];
    if (view == nil) {
		return;
    }
    
    if (view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        view.frame = frame;
        [self.scrollView addSubview:view];
    }
}

- (void)previousPage {
    if (_page - 1 > 0) {
		// update the scroll view to the appropriate page
		CGRect frame = self.scrollView.frame;
		frame.origin.x = frame.size.width * (_page - 1);
		frame.origin.y = 0;
		
		[self.scrollView scrollRectToVisible:frame animated:YES];
		
		self.pageControl.currentPage = _page - 1;
		// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
		_pageControlUsed = YES;
	}
}

- (void)nextPage {
    if (_page + 1 > self.pageControl.numberOfPages) {
		// update the scroll view to the appropriate page
		CGRect frame = self.scrollView.frame;
		frame.origin.x = frame.size.width * (_page + 1);
		frame.origin.y = 0;
		
		[self.scrollView scrollRectToVisible:frame animated:YES];
		
		self.pageControl.currentPage = _page + 1;
        
		// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
		_pageControlUsed = YES;
	}
}

- (IBAction)changePage:(id)sender {
    int page = ((UIPageControl *)sender).currentPage;
	
	// update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
	
	[self.scrollView scrollRectToVisible:frame animated:YES];
	
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    _pageControlUsed = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _page = self.pageControl.currentPage;
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (_pageControlUsed || _rotating) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	if (self.pageControl.currentPage != page) {
		self.pageControl.currentPage = page;
		_page = page;
	}
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.viewsArray = nil;
    self.scrollView = nil;
    self.pageControl = nil;
}

@end
