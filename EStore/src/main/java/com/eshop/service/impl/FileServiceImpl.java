package com.eshop.service.impl;

import com.eshop.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@Service
public class FileServiceImpl implements FileService {
    @Autowired
    ServletContext app;

    @Override
    public Path getPath(String folder, String fileName) {
        File dir = Paths.get(app.getRealPath("/files"), folder).toFile();
        if (!dir.exists()) {
            dir.mkdirs();
        }
        return Paths.get(dir.getAbsolutePath(), fileName);
    }

    @Override
    public byte[] readFile(String folder, String fileName) {
        Path path = this.getPath(folder, fileName);
        try {
            return Files.readAllBytes(path);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<String> saveFiles(String folder, MultipartFile[] files) {
        List<String> fileNames = new ArrayList<String>();
        for (MultipartFile file : files) {
            String name = System.currentTimeMillis() + file.getOriginalFilename();
            String fileName = Integer.toHexString(name.hashCode()) + name.substring(name.lastIndexOf("."));
            Path path = this.getPath(folder, fileName);
            try {
                file.transferTo(path);
                fileNames.add(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return fileNames;
    }

    @Override
    public void deleteFile(String folder, String fileName) {
        Path path = this.getPath(folder, fileName);
        path.toFile().delete();
    }

    @Override
    public List<String> getFileNames(String folders) {
        List<String> fileNames = new ArrayList<String>();
        File dir = Paths.get(app.getRealPath("/uploadFiles"), folders).toFile();
        if (!dir.exists()) {
            File[] files = dir.listFiles();
            for(File file : files) {
                fileNames.add(file.getName());
            }
        }
        return fileNames;
    }
}
