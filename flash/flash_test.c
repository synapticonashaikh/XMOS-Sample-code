/*****************************************************************************/
/*                                 Includes                                  */
/*****************************************************************************/

#include <stdio.h>
#include <platform.h>
#include <quadflashlib.h>

/*****************************************************************************/
/*                             Hash definition                              */
/*****************************************************************************/

/*****************************************/
/*  DFU Settings                         */
/*****************************************/
#define FL_QUADDEVICE_AT25FF321A \
{ \
    0,                      /* UNKNOWN */ \
    256,                    /* page size */ \
    16384,                  /* num pages */ \
    3,                      /* address size */ \
    3,                      /* log2 clock divider */ \
    0x9F,                   /* QSPI_RDID */ \
    0,                      /* id dummy bytes */ \
    3,                      /* id size in bytes */ \
    0x1F4708,               /* device id */ \
    0x20,                   /* QSPI_SE */ \
    4096,                   /* Sector erase is always 4KB */ \
    0x06,                   /* QSPI_WREN */ \
    0x04,                   /* QSPI_WRDI */ \
    PROT_TYPE_SR,           /* Protection via SR */ \
    {{0x3C,0x00},{0,0}},    /* QSPI_SP, QSPI_SU */ \
    0x02,                   /* QSPI_PP */ \
    0xEB,                   /* QSPI_READ_FAST */ \
    1,                      /* 1 read dummy byte */ \
    SECTOR_LAYOUT_REGULAR,  /* mad sectors */ \
    {4096,{0,{0}}},         /* regular sector sizes */ \
    0x05,                   /* QSPI_RDSR */ \
    0x01,                   /* QSPI_WRSR */ \
    0x01,                   /* QSPI_WIP_BIT_MASK */ \
}

  #define BOARD_QSPI_SPEC     FL_QUADDEVICE_AT25FF321A
  #define FLASH_CLKBLK        XS1_CLKBLK_1

/*****************************************************************************
*                                  Global Variable                           *
*****************************************************************************/
fl_QuadDeviceSpec qspi_spec = BOARD_QSPI_SPEC;
fl_QSPIPorts qspi_ports = 
{
    .qspiCS = PORT_SQI_CS,
    .qspiSCLK = PORT_SQI_SCLK,
    .qspiSIO = PORT_SQI_SIO,
    .qspiClkblk = FLASH_CLKBLK,
};
/*****************************************************************************
*                                  Functions                                 *
*****************************************************************************/
int main ( )
{
  int a = fl_connectToDevice(&qspi_ports,&qspi_spec,255);
  printf("CONNECT=%d\n\r",a);
  int b = fl_getFlashType();
  printf("TYPE=%d\n\r",b);
  int c= fl_getFlashSize();
  printf("size=%d\n\r",c);

  return 0;
}