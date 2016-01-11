//
//  main.m
//  textFile
//
//  Created by Lynn on 16/1/10.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FILE* wordFile = fopen("/Users/lynn/IOS_Learning/IOS学习/0109Reviews/textFile/words.txt", "r");
        char word[100];
        
        while (fgets(word, 100, wordFile)) {
            word[strlen(word)-1] = '\0';
            NSLog(@"%s is %lu characters long",word,strlen(word));
        }
        fclose(wordFile);
    }
    return 0;
}
