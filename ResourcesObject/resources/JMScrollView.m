//
//  JMLoopScrollView.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/20.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "JMScrollView.h"

@implementation JMScrollView

+ (JMScrollView *)scrollViewWithFrame:(CGRect)frame
                               Images:(NSMutableArray *)imgArray {
    
    JMScrollView *view = [[JMScrollView alloc]initWithFrame:frame];
    
    [view viewAddSubview:frame Images:imgArray];
    
    return view;
}

- (void)viewAddSubview:(CGRect)frame
                Images:(NSMutableArray *)imgArray {
    int count = [imgArray count];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:frame];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(frame.size.width*count, frame.size.height);
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _pageCtl = [[UIPageControl alloc]initWithFrame:CGRectMake((frame.size.width-count*15)/2.f, frame.size.height*10/11, count*15, 30)];
    _pageCtl.numberOfPages = count;
    _pageCtl.currentPage = 0;
    [_pageCtl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageCtl];
    
    for (int i = 0; i < count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
        imgView.image = imgArray[i];
        [_scrollView addSubview:imgView];
        
        if (i== count-1) {
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lastPageTaaped:)];
            [imgView addGestureRecognizer:tap];
        }
    }
}

- (void)changePage {
    int currntPage = _pageCtl.currentPage;
    [_scrollView setContentOffset:CGPointMake(currntPage * self.frame.size.width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int currntPage = (int)((scrollView.contentOffset.x+self.frame.size.width/2.f)/self.frame.size.width);
    if(currntPage < _pageCtl.numberOfPages) {
        _pageCtl.currentPage = currntPage;
    }
}


-(void)lastPageTaaped:(UITapGestureRecognizer *)tap
{
    [self.scrollViewDelegate lastPageClick];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
