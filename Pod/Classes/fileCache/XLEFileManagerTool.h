//
//  XLEFileManagerTool.h
//  Pods
//
//  Created by Randy on 15/1/19.
//

#import <Foundation/Foundation.h>

#define XLEDocDir [XLEFileManagerTool docDir]
#define XLELibraryDir [XLEFileManagerTool libraryDir]
#define XLELibPrefDir [XLEFileManagerTool libPrefDir]
#define XLECachesDir [XLEFileManagerTool cachesDir]
#define XLETmpDir [XLEFileManagerTool tmpDir]

@interface XLEFileManagerTool : NSObject

/*获取Documents目录路径*/
+ (NSString *)docDir;

/*Library*/
+ (NSString *)libraryDir;

/*Library/Preference*/
+ (NSString *)libPrefDir;

/*获取Caches目录路径*/
+ (NSString *)cachesDir;

/*获取tmp目录路径*/
+ (NSString *)tmpDir;

/*获取沙盒主目录路径*/
+ (NSString *)homeDir;

/*app路径*/
+ (NSString *)appDir;

/*文件是否存在*/
+ (BOOL)isFileExistedWithPath:(NSString *)path;

/*创建指定名字的文件*/
+ (BOOL)createFileWithPath:(NSString *)path;

/*创建指定名字的文件夹*/
+ (BOOL)createDirectoryWithPath:(NSString *)path;

/*删除文件*/
+ (BOOL)deleteFileWithPath:(NSString *)path;

/*获取某个目录下所有的文件路径*/
+ (NSArray *)filePathsWithDirPath:(NSString *)path;
//删除目录下的所有文件
+ (BOOL)deleteFilesWithDirPath:(NSString *)path;

//遍历文件夹获得文件夹大小，返回多少M
+ (float)folderSizeAtPath:(NSString*) folderPath;

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath;

@end
