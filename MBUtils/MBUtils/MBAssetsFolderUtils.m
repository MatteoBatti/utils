//
//  MBAssetsFoldersUtils.m
//  MBUtils
//
//  Created by Matteo Battistini on 29/06/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBAssetsFolderUtils.h"

@implementation MBAssetsFolderUtils

+ (NSURL *) applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
    
}


+ (NSURL *) getDocumetFolder:(NSString *)string
{
    return [[MBAssetsFolderUtils applicationDocumentsDirectory] URLByAppendingPathComponent:string];
}

+ (void) createDocumentFolder:(NSString *)folderName
{
    NSFileManager *fileManeger = [NSFileManager defaultManager];
    if (![fileManeger fileExistsAtPath:[MBAssetsFolderUtils getDocumetFolder:folderName].path]) {
        NSError *error = nil;
        [fileManeger createDirectoryAtURL:[MBAssetsFolderUtils getDocumetFolder:folderName]
              withIntermediateDirectories:YES
                               attributes:nil
                                    error:&error];
        if (error) {
            DLog(@"[ERROR] + (void) createDocumentFolder:(NSString *)folderName -----> %@", error);
        }
    }
        
}


+(NSArray *) getContentsOfDocumentFolder:(NSString *)folderName
{
    NSFileManager *fileManeger = [NSFileManager defaultManager];
    if ([fileManeger fileExistsAtPath:[MBAssetsFolderUtils getDocumetFolder:folderName].path]) {
        NSError *error = nil;
        NSArray *contents = [fileManeger contentsOfDirectoryAtPath:[MBAssetsFolderUtils getDocumetFolder:folderName].path error:&error];
        return contents;
    } else return nil;
}

+(NSArray *) getContentsPathOfDocumentFolder:(NSString *)folderName
{
    NSFileManager *fileManeger = [NSFileManager defaultManager];
    if ([fileManeger fileExistsAtPath:[MBAssetsFolderUtils getDocumetFolder:folderName].path]) {
        NSError *error = nil;
        NSArray *contents = [fileManeger contentsOfDirectoryAtPath:[MBAssetsFolderUtils getDocumetFolder:folderName].path error:&error];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (NSString *fileName in contents) {
            NSString *filePath = [[[MBAssetsFolderUtils getDocumetFolder:folderName] path] stringByAppendingPathComponent:fileName];
            [result addObject:filePath];
        }
        return result;
    } else return nil;
}

+(NSArray *) getContentsPathOfDocumentFolder:(NSString *)folderName withExtension:(NSString *) extension
{
    NSFileManager *fileManeger = [NSFileManager defaultManager];
    if ([fileManeger fileExistsAtPath:[MBAssetsFolderUtils getDocumetFolder:folderName].path]) {
        NSError *error = nil;
        NSArray *contents = [fileManeger contentsOfDirectoryAtPath:[MBAssetsFolderUtils getDocumetFolder:folderName].path error:&error];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (NSString *fileName in contents) {
            if ([[fileName pathExtension] isEqualToString:extension]){
                NSString *filePath = [[[MBAssetsFolderUtils getDocumetFolder:folderName] path] stringByAppendingPathComponent:fileName];
                [result addObject:filePath];
            }
        }
        return result;
    } else return nil;
}



+(NSArray *) getContentsOfDocumentFolder:(NSString *)folderName withExtension:(NSString *)extension
{
    NSFileManager *fileManeger = [NSFileManager defaultManager];
    if ([fileManeger fileExistsAtPath:[MBAssetsFolderUtils getDocumetFolder:folderName].path]) {
        NSError *error = nil;
        NSArray *contents = [fileManeger contentsOfDirectoryAtPath:[MBAssetsFolderUtils getDocumetFolder:folderName].path error:&error];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (NSString *fileName in contents) {
            if ([[fileName pathExtension] isEqualToString:extension]){
                [result addObject:fileName];
            }
            
        }
        return result;
    } else return nil;
}



+ (void) removeDocumentFolder:(NSString *)folderName
{
    NSFileManager *fileManeger = [NSFileManager defaultManager];
    if ([fileManeger fileExistsAtPath:[MBAssetsFolderUtils getDocumetFolder:folderName].path]) {
        NSError *error = nil;
        [fileManeger removeItemAtURL:[MBAssetsFolderUtils getDocumetFolder:folderName] error:&error];
        if (error) {
            DLog(@"[ERROR] + (void) removeDocumentFolder:(NSString *)folderName -----> %@", error);
        }
    }
}


@end
