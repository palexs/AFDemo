#import "AFPortfolioViewController.h"
#import "MIMColor.h"
#import "MIMWallGraph.h"
#import "PaddedPieChart.h"
#import "BasicPieChart.h"

@interface AFPortfolioViewController () <WallGraphDelegate, MIMPieChartDelegate>
{
    MIMWallGraph *mWallGraph;
    PaddedPieChart *mPieChart;
    BasicPieChart *mBasicPieChart;
    
    NSMutableArray *dataArrayFromCSV;
    NSMutableArray *xDataArrayFromCSV;
    
    NSArray *yValuesArray;
    NSArray *xValuesArray;
    NSArray *xTitlesArray;
    
    NSDictionary *xProperty;
    NSDictionary *yProperty;
    
    NSDictionary *horizontalLinesProperties;
    NSDictionary *verticalLinesProperties;
}

@end

@implementation AFPortfolioViewController

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
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"PortfolioViewOne" owner:self options:nil];
    UIView *one = [nibObjects objectAtIndex:0];
    
    nibObjects = [[NSBundle mainBundle] loadNibNamed:@"PortfolioViewTwo" owner:self options:nil];
    UIView *two = [nibObjects objectAtIndex:0];
    
    nibObjects = [[NSBundle mainBundle] loadNibNamed:@"PortfolioViewThree" owner:self options:nil];
    UIView *three = [nibObjects objectAtIndex:0];
    
    NSArray *views = [NSArray arrayWithObjects:one, two, three, nil];
    self.viewsArray = views;
    
    // Add graphs to corresponding widgets
    [self addWallGraphToView:[self.viewsArray objectAtIndex:0]];
    [self addPieChartToView:[self.viewsArray objectAtIndex:1]];
}

- (void)addWallGraphToView:(UIView*)v
{
    //Test for hiding Y-Axis
    //NSArray *keys = [NSArray arrayWithObjects:@"hide", nil];
    //NSArray *values = [NSArray arrayWithObjects:[NSNumber numberWithBool:YES], nil];
    //yProperty = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    NSArray *array1 = [NSArray arrayWithObjects:@"104.622",
                     @"104.270",
                     @"100.635",
                     @"103.684",
                     @"105.483",
                     @"105.101",
                     @"105.447",
                     @"104.468",
                     @"102.064",
                     @"100.319",
                     @"100.145",
                     @"100.567", nil];
    
    NSArray *array2 = [NSArray arrayWithObjects:@"72.80",
                     @"69.55",
                     @"34.50",
                     @"33.96",
                     @"45.31",
                     @"54.05",
                     @"61.45",
                     @"62.57",
                     @"65.00",
                     @"74.58",
                     @"63.70",
                     @"69.58", nil];
    
    yValuesArray = [[NSArray alloc] initWithObjects:array1, array2, nil];
    
    xValuesArray = [[NSArray alloc] initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
    
    xTitlesArray = [[NSArray alloc] initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
    
    mWallGraph = [[MIMWallGraph alloc] initWithFrame:CGRectMake(0, 10, v.frame.size.width - 20, v.frame.size.height - 20)];
    mWallGraph.delegate = self;
    mWallGraph.isGradient = YES;
    mWallGraph.xTitleStyle = X_TITLES_STYLE1;
    [mWallGraph drawMIMWallGraph];
    [v addSubview:mWallGraph];
    
    //All WIthout Anchors
}

- (void)addPieChartToView:(UIView*)v
{
    /*
    mPieChart = [[PaddedPieChart alloc]initWithFrame:CGRectMake(10, 10, v.frame.size.width - 20, v.frame.size.height - 20)];
    mPieChart.delegate = self;
    mPieChart.paddingPixels = 2.0;
    mPieChart.borderWidth = 2.0;
    [mPieChart drawPieChart];
    [v addSubview:mPieChart];
    
    [v addSubview:[self createLabelWithText:@"Label text"]];
     */
    
    mBasicPieChart = [[BasicPieChart alloc]initWithFrame:CGRectMake(10, 10, v.frame.size.width - 20, v.frame.size.height - 50)];
    mBasicPieChart.delegate = self;
    mBasicPieChart.showInfoBox = YES;
    mBasicPieChart.tint = GREENTINT; //Don't give colors in delegate method now,-(NSArray *)colorsForPie:(id)pieChart , return nil.
    mBasicPieChart.infoBoxSmoothenCorners = YES;
    mBasicPieChart.fontName = [UIFont fontWithName:@"TrebuchetMS" size:13];
    mBasicPieChart.fontColor = [MIMColorClass colorWithComponent:@"0.8,0.2,0.2"];
    [v addSubview:mBasicPieChart];
    [mBasicPieChart drawPieChart];
    [v addSubview:[self createLabelWithText:@"Label text"]];
}

- (UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 230, 310, 20)];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setText:text];
    lbl.numberOfLines = 5;
    [lbl setTextAlignment:UITextAlignmentCenter];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [lbl setMinimumFontSize:8];
    return lbl;
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

#pragma mark -
#pragma mark - WallGraphDelegate Delegate Methods

- (NSArray *)valuesForGraph:(id)graph
{
    return yValuesArray;
}

- (NSArray *)valuesForXAxis:(id)graph
{
    return xValuesArray;
}

- (NSArray *)titlesForXAxis:(id)graph
{
    return xTitlesArray;
}

- (NSDictionary *)xAxisProperties:(id)graph
{
    return xProperty;
}

- (NSDictionary *)yAxisProperties:(id)graph
{
    return yProperty;
}

- (NSDictionary *)horizontalLinesProperties:(id)graph
{
    return horizontalLinesProperties;
}

- (NSDictionary*)verticalLinesProperties:(id)graph
{
    return verticalLinesProperties;
}

#pragma mark -
#pragma mark - Piechart Delegate methods

- (float)radiusForPie:(id)pieChart
{
    return 100.0;
}

- (NSArray *)colorsForPie:(id)pieChart
{
    NSArray *colorsArray;
    
    MIMColorClass *color1 = [MIMColorClass colorWithComponent:@"137,215,234"];
    MIMColorClass *color2 = [MIMColorClass colorWithComponent:@"239,95,100"];
    MIMColorClass *color3 = [MIMColorClass colorWithComponent:@"127,186,140"];
    MIMColorClass *color4 = [MIMColorClass colorWithComponent:@"247,144,187"];
    MIMColorClass *color5 = [MIMColorClass colorWithComponent:@"249,219,122"];
    
    colorsArray=[NSArray arrayWithObjects:color1,color2,color3,color4,color5, nil];
    
    return colorsArray;
}

- (NSArray *)valuesForPie:(id)pieChart
{
    return [NSArray arrayWithObjects:@"10000", @"21000", @"24000", @"11000", @"5000", nil];
}

- (NSArray *)titlesForPie:(id)pieChart
{
    return [NSArray arrayWithObjects:@"Fund1", @"Fund2", @"Fund3", @"Fund4", @"Fund5", nil];
}

- (NSArray *)bordercolorsForPie:(id)pieChart
{
    
    NSArray *bcolorsArray;
    
    MIMColorClass *color1=[MIMColorClass colorWithComponent:@"108,178,205"];
    MIMColorClass *color2=[MIMColorClass colorWithComponent:@"206,69,90"];
    MIMColorClass *color3=[MIMColorClass colorWithComponent:@"107,160,124"];
    MIMColorClass *color4=[MIMColorClass colorWithComponent:@"229,128,168"];
    MIMColorClass *color5=[MIMColorClass colorWithComponent:@"226,198,90"];
    
    bcolorsArray=[NSArray arrayWithObjects:color1,color2,color3,color4,color5, nil];
    
    return bcolorsArray;
}

/*
-(MIMColorClass *)colorForBackground:(id)pieChart
{
    MIMColorClass *bgColor;
    
    if(pieChart == mPieChart1)
        bgColor = [MIMColorClass colorWithComponent:@"1.0,1.0,1.0"];
    
    
    return bgColor;
}*/

@end
