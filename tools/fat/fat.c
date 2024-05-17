#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


#define true 1
#define false 0

// type definitions
typedef uint8_t bool;

typedef struct 
{
    uint8_t BootJumpInstruction[3];
    uint8_t OemIdentifier[8];
    uint16_t BytesPerSector;
    uint8_t SectorsPerCluster;
    uint16_t ReservedSectors;
    uint8_t FatCount;
    uint16_t DirEntryCount;
    uint16_t TotalSectors;
    uint8_t MediaDescriptorType;
    uint16_t SectorsPerFat;
    uint16_t SectorsPerTrack;
    uint16_t Heads;
    uint32_t HiddenSectors;
    uint32_t LargeSectorCount;

    // EBR
    uint8_t DriveNumber;
    uint8_t _Reserved;
    uint8_t Signature;
    uint32_t VolumeId;          
    uint8_t VolumeLabel[11];    
    uint8_t SystemId[8];

    

} __attribute__((packed)) BootSector;


bool ReadBootSector() {
    
}

int main(int argc, char** argv) {
    if (argc < 3) {
       printf("Syntax: %s <disk image> <filename>\n", argv[0]);
       return -1;
    }

    FILE* disk = fopen(argv[0], "rb");
    return 0;
}