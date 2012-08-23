//
//  ChapterPO.h
//  beautyReader
//  文章xml解析类
//  Created by superjoo on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChapterPO : NSObject {
    NSString *chapterName;//章节名
    NSString *title_en;//章节介绍,英文
    NSString *title_zh;//章节介绍,中文
    NSString *subject;//所属二级标题
    NSString *chapterAudioUrl;//文章音频文件地址
    NSString *chapter_en;//章节英文文本文件
    NSString *chapter_zh;//章节翻译文本文件
    NSString *chapter_en_zh;//英汉互译翻译文本文件
    NSString *chapter_sentence;//妙语文本文件
    NSString *chapter_words;//重点词汇
    NSString *sequence;//显示顺序
    NSString *comment;//注释
}

@property (nonatomic,retain) NSString *chapterName;//章节名
@property (nonatomic,retain) NSString *title_en;//章节介绍,英文
@property (nonatomic,retain) NSString *title_zh;//章节介绍,中文
@property (nonatomic,retain) NSString *subject;//所属二级标题
@property (nonatomic,retain) NSString *chapterAudioUrl;//文章音频文件地址
@property (nonatomic,retain) NSString *chapter_en;//章节英文文本文件
@property (nonatomic,retain) NSString *chapter_zh;//章节翻译文本文件
@property (nonatomic,retain) NSString *chapter_en_zh;//英汉互译翻译文本文件
@property (nonatomic,retain) NSString *chapter_sentence;//妙语文本文件
@property (nonatomic,retain) NSString *chapter_words;//重点词汇
@property (nonatomic,retain) NSString *sequence;//显示顺序
@property (nonatomic,retain) NSString *comment;//注释

+(ChapterPO*) parseChapter:(NSDictionary*)dictionary;

@end
