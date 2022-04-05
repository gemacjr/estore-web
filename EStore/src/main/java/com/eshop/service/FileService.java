package com.eshop.service;

import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Path;
import java.util.List;

public interface FileService {
    Path getPath (String folder, String fileName);
    byte[] readFile(String folder, String fileName);
    List<String> saveFiles(String folder, MultipartFile[] multipathFiles);
    void deleteFile(String folder, String fileName);
    List<String> getFileNames(String folders);
}
