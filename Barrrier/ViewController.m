//
//  ViewController.m
//  Barrrier
//
//  Created by mac on 15/6/17.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    //定义成员变量
    dispatch_queue_t _queue;
}

@property (nonatomic,strong) NSMutableArray *photoList;

@end

@implementation ViewController

-(NSMutableArray *)photoList{
    if (_photoList == nil) {
        _photoList = [NSMutableArray array];
    }
    return _photoList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建并发队列
    _queue = dispatch_queue_create("loadPhotoQueue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 10; i++) {
        [self loadPhoto:i];
    }

}

//模拟网络加载图片，一个任务加载一个图片
- (void)loadPhoto:(int)index {
    
    dispatch_async(_queue, ^{
        //模拟每次下载延时, 为了演示一个bug
        [NSThread sleepForTimeInterval:1.0];
        
        NSString *filename = [NSString stringWithFormat:@"%02d.jpg",index+1];
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        //将之前所有添加的异步任务执行完成之后，阻塞，在同一线程中，顺序执行 
        dispatch_barrier_async(_queue, ^{
            // 将图像添加到数组
            [self.photoList addObject:image];
            
            NSLog(@"添加图片   %@",[NSThread currentThread]);
        });
        
        
        
        NSLog(@" %@下载完成 %@",filename,[NSThread currentThread]);
    });
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"图片数量 %zd",self.photoList.count);
}

@end
