/*
 Copyright (C) 2011- 2012  Reetu Raj (reetu.raj@gmail.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 and associated documentation files (the “Software”), to deal in the Software without 
 restriction, including without limitation the rights to use, copy, modify, merge, publish, 
 distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
 the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or 
 substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *///
//  MIMPieChart.m
//  MIMChartLib
//
//  Created by Reetu Raj on 10/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "MIMPieChart.h"
#import "MIMColor.h"
#import "MIMColorClass.h"

//Private Methods of PieChart
@interface MIMPieChart()

-(void)findCenter;
-(int)findQuadrant:(CGPoint)touchPoint;

@end





@implementation MIMPieChart
@synthesize radius_;

@synthesize valueArray_;
@synthesize angleArrays_;
@synthesize titleArray_;
@synthesize colorArray_;
@synthesize borderColorArray_;


@synthesize gradientArray_;
@synthesize gradientTypeArray_;

@synthesize backgroundColor;
@synthesize enableBottomTitles;
@synthesize glossEffect;
@synthesize borderWidth_;

@synthesize tintValue;
@synthesize tint;

@synthesize centerX_;
@synthesize centerY_;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}
-(void)readFromCSV:(NSString*)path  TitleAtColumn:(int)tcolumn  DataAtColumn:(int)dcolumn
{
    
    
    
    valueArray_=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    int k=0;
    for (id string in linesArray)
        if(k<[linesArray count]-1){
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            [valueArray_ addObject:[columnArray objectAtIndex:dcolumn]];
            k++;
            
        }
    
    
    titleArray_=[[NSMutableArray alloc]init];
    
    
    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    k=0;
    for (id string in linesArray)
        if(k<[linesArray count]-1){
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            [titleArray_ addObject:[columnArray objectAtIndex:tcolumn]];
            k++;
            
        }
    
    
}


-(void)readFromArray:(NSArray*)valuearray  Title:(NSArray *)titlesArray  Color:(NSArray *)colorsArray
{
    
    
    
    valueArray_=[[NSMutableArray alloc]initWithArray:valuearray];
    titleArray_=[[NSMutableArray alloc]initWithArray:titlesArray];
}

-(void)initAndWarnings
{
    if(radius_==0)
        NSLog(@"WARNING::Radius is 0. Please set some value to radius.");
    
    if(self.backgroundColor)
        [self setBackgroundColor:backgroundColor];
    else
        [self setBackgroundColor:[UIColor whiteColor]];
    
    
}

-(void)drawPieChart
{
    selectedPie=-99;
    [self initAndWarnings];
    [self findCenter];
    [self drawBottomTitlesText];
    [self setNeedsDisplay];
    
    
    
}


-(void)drawBottomTitlesText
{
    float sum=0;
    for(int i=0;i<[valueArray_ count];i++)
    {
        
        sum+=[[valueArray_ objectAtIndex:i] floatValue];
    }
    
    
    //Only  text
    for(int i=0;i<[titleArray_ count];i++)
    {
        
        float percent=([[valueArray_ objectAtIndex:i] floatValue]/sum)*100;
        
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(2*radius_ + 60,i*30+ 25,130,30)];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setTextAlignment:UITextAlignmentLeft];
        [title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [title setTextColor:[UIColor blackColor]];
        [title setText:[NSString stringWithFormat:@"  %@  (%.0f %@)",[titleArray_ objectAtIndex:i],percent,@"%"]];
        title.tag=1000+i;
        [self addSubview:title];
    }
    
}

-(void)highlightTheTitle
{
    //First remove all the highlights
    for (id view in self.subviews)
        if([view isKindOfClass:[UILabel class]]){
            
            UILabel *viewLabel=(UILabel *)view;
            
            [viewLabel.layer setBorderWidth:0.0];
            [viewLabel.layer setShadowOpacity:0];
        }
    
    
    
    UILabel *view=(UILabel *)[self viewWithTag:1000+selectedPie];
    [view.layer setBorderColor:[UIColor grayColor].CGColor];
    [view.layer setBorderWidth:1.0];        
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:5.0];
    [view.layer setShadowRadius:2.0];
    [view.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [view.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    [view.layer setShadowOpacity:0.8];
    
}




-(void)drawBottomTitles:(CGContextRef)context
{
    int totalColors=[MIMColor sizeOfColorArray];
    
    int tintOffset;
    if(tint==REDTINT)
        tintOffset=17;
    if(tint==GREENTINT)
        tintOffset=0;
    if(tint==BEIGETINT)
        tintOffset=30;
    
    
    //Draw the squares ONly
    
    for(int i=0;i<[titleArray_ count];i++)
    {
        
        NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+tintOffset)%totalColors];    
        float red=[[colorDic valueForKey:@"red"] floatValue];
        float green=[[colorDic valueForKey:@"green"] floatValue];
        float blue=[[colorDic valueForKey:@"blue"] floatValue];
        UIColor *color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    
        
        
        //Simple Colored Rect
        CGRect rectangle = CGRectMake(2*radius_ + 30,i*30+ 30,15,15);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rectangle);
        //    
    }
}



- (void)drawRect:(CGRect)rect
{
    
    
    
    int c=[valueArray_ count];
    
    // CGFloat angleArray[c];
    angleArrays_=[[NSMutableArray alloc]initWithCapacity:c];
    CGFloat offset=0;
    int sum=0;
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    
    //Draw the background with the gray Gradient
    float _viewWidth=self.frame.size.width;
    float _viewHeight=self.frame.size.height;
    
    
    
    CGFloat BGLocations[3] = { 0.0, 0.65, 1.0 };
    CGFloat BgComponents[12] = { 1.0, 1.0, 1.0 , 1.0,  // Start color
        0.9, 0.9, 0.9 , 1.0,  // Start color
        0.75, 0.75, 0.75 , 1.0 }; // Mid color and End color
    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
    
    
    CGPoint startBg = CGPointMake(_viewWidth/2,_viewHeight/2); 
    CGFloat endRadius=MAX(_viewWidth/2, _viewHeight/2);
    
    
    CGContextDrawRadialGradient(context, bgRadialGradient, startBg, 0, startBg, endRadius, kCGGradientDrawsAfterEndLocation);
    CGColorSpaceRelease(BgRGBColorspace);
    CGGradientRelease(bgRadialGradient);
    
    
    int totalColors=[MIMColor sizeOfColorArray];
    
    
    for(int i=0;i<[valueArray_ count];i++)
    {
        
        sum+=[[valueArray_ objectAtIndex:i] intValue];
    }
    
    for(int i=0;i<[valueArray_ count];i++)
    {
        
        float myAngle=(float)(([[valueArray_ objectAtIndex:i] intValue])/(float)sum)*(2*3.14); // in radians
        [angleArrays_ addObject:[NSNumber numberWithFloat:myAngle]];
        
        CGContextMoveToPoint(context, centerX_ , centerY_);
        
        if(selectedPie==i)
        {
            if(returnBackToOriginalLocation){
                CGContextAddArc(context, centerX_, centerY_, radius_,offset,offset+myAngle, 0);
                selectedPie=-99;
            }
            else
                CGContextAddArc(context, centerX_, centerY_, radius_+10,offset,offset+myAngle, 0);
            
            
        }
        else
            CGContextAddArc(context, centerX_, centerY_, radius_,offset,offset+myAngle, 0);
        
        offset+=myAngle;
        
        int tintOffset;
        if(tint==REDTINT)
            tintOffset=17;
        if(tint==GREENTINT)
            tintOffset=0;
        if(tint==BEIGETINT)
            tintOffset=30;
        
        NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+tintOffset)%totalColors];    //i+17 brown tint//30 dark colors(like beige)// // total 43
        float red=[[colorDic valueForKey:@"red"] floatValue];
        float green=[[colorDic valueForKey:@"green"] floatValue];
        float blue=[[colorDic valueForKey:@"blue"] floatValue];
        
        UIColor *color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    
        CGContextSetFillColorWithColor(context, color.CGColor);    
        
        
        
        
        
        CGContextSetShadowWithColor(context, CGSizeMake(-2.0, 2.0), 2.0, [UIColor blackColor].CGColor);
        
        CGContextClosePath(context); 
        CGContextFillPath(context);
        
        
    }
    
    UIGraphicsPopContext();
    
    /*
     float innerRadius=300;
     
     CGContextSetFillColorWithColor( context, [UIColor lightGrayColor].CGColor );
     CGContextSetBlendMode(context, kCGBlendModeClear);
     CGRect holeRect= CGRectMake(_centerX - innerRadius/2 , _centerY - innerRadius/2, innerRadius, innerRadius);
     CGContextFillEllipseInRect( context, holeRect ); 
     CGContextSetShadowWithColor(context, CGSizeMake(-2.0, 2.0), 2.0, [UIColor blackColor].CGColor);
     */
    
    
    //Create the titles in the bottom
    if([titleArray_ count]>0)
    {
        
        [self drawBottomTitles:context];
        
        
    }
    
    
    
}

-(void)findCenter
{
    //Find the angle of the touchPoint.
    //Draw the background with the gray Gradient
    float _viewHeight=self.frame.size.height;
    
    
    centerX_=radius_ + 20;
    centerY_=_viewHeight/2;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint=[touch locationInView:self];
    
    float angle=atanf((touchPoint.y -centerY_)/(touchPoint.x-centerX_));
    int quadrant=[self findQuadrant:touchPoint];
    
    if(quadrant !=0)
    {
        
        float radian;
        
        switch (quadrant) {
            case 1:
            {
                radian=(2*3.14)+angle;
            }
                break;
                
            case 2:
            {
                radian=3.14+angle;
            }
                break;
                
            case 3:
            {
                angle=1.57+angle;
                radian=1.57+angle;
                
            }
                break;
                
            case 4:
            {
                radian=angle;
                
            }
                break;
        }
        
        //Find which pie has to be highlighted.
        int pieToBeSelected=0;
        float offset=0;
        
        
        for(int i=0;i<[valueArray_ count];i++)
        {
            
            float myAngle=[[angleArrays_ objectAtIndex:i] floatValue];
            
            if((radian>=offset)&&(radian<offset+myAngle)){
                pieToBeSelected=i;
                break;
            }
            
            offset+=myAngle;
        }
        
        if(selectedPie==pieToBeSelected)
        {
            
            //Selected Pie is touched Again to return it back to original Location
            returnBackToOriginalLocation=YES;
            
            
        }else{
            
            selectedPie=pieToBeSelected;
            returnBackToOriginalLocation=NO;
            
        }
        [self highlightTheTitle];
        [self setNeedsDisplay];
        
    }
    
    
}

-(int)findQuadrant:(CGPoint)touchPoint
{
    //top right
    CGRect rect=CGRectMake(centerX_, 0, radius_,centerY_ );
    BOOL contains = CGRectContainsPoint(rect, touchPoint);
    if(contains)
        return 1;
    
    
    //top left
    rect=CGRectMake(0, 0, radius_+20, centerY_);
    contains = CGRectContainsPoint(rect, touchPoint);
    if(contains)
        return 2;
    
    //bottom left
    rect=CGRectMake(0, centerY_, radius_ + 20, centerY_);
    contains = CGRectContainsPoint(rect, touchPoint);
    if(contains)
        return 3;
    
    
    //bottom right
    rect=CGRectMake(centerX_, centerY_, radius_, centerY_);
    contains = CGRectContainsPoint(rect, touchPoint);
    if(contains)
        return 4;
    
    
    
    
    return 0;
}


-(float)returnSum:(NSArray *)array
{
    float sum=0.0;
    
    for(int i=0;i<[array count];i++)
        sum+=[[array objectAtIndex:i] floatValue];
    
    return sum;
    
}


- (void)dealloc
{
    ////[super dealloc];
}



@end
