package com.eshop.controller.api;

import com.eshop.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.websocket.server.PathParam;
import java.util.List;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/files")
public class FileRestController {
    @Autowired
    private FileService fileService;

    @GetMapping("/{folder}/{fileName}")
    public byte[] download(@PathVariable("folder") String folder, @PathVariable("fileName") String fileName) {
        return fileService.readFile(folder, fileName);
    }

    @PostMapping("/{folder}")
    public List<String> upload(@PathVariable("folder") String folder, @PathParam("files") MultipartFile[] files) {
        return fileService.saveFiles(folder, files);
    }

    @DeleteMapping("/{folder}/{fileName}")
    public void delete(@PathVariable("folder") String folder, @PathVariable("fileName") String fileName) {
        fileService.deleteFile(folder, fileName);
    }

    @GetMapping("/{folder}")
    public List<String> getFileNames(@PathVariable("folder") String folder) {
        return fileService.getFileNames(folder);
    }
}
