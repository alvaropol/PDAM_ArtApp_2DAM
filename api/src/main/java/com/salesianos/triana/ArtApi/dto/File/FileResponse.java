package com.salesianos.triana.ArtApi.dto.File;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class FileResponse {
    private String name;
    private String url;
    private String type;
    private long size;
}