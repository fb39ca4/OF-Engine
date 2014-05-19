
enum                            // hardcoded texture numbers
{
    DEFAULT_SKY = 0,
    DEFAULT_GEOM,
    NUMDEFAULTSLOTS
};

#define OCTAVERSION 33

struct octaheader
{
    char magic[4];              // "OCTA"
    int version;                // any >8bit quantity is little endian
    int headersize;             // sizeof(header)
    int worldsize;
    int numents;
    int numpvs;
    int lightmaps;
    int blendmap;
    int numvars;
    int numvslots;
};

#define TMAPVERSION 1

struct tmapheader
{
    char magic[4];              // "TMAP"
    int version;                // any >8bit quantity is little endian
    int headersize;             // sizeof(header)
    int worldsize;
    int numents;
    int numpvs;
    int blendmap;
    int numvars;
    int numvslots;
};

#define MAPVERSION 1            // bump if map format changes, see worldio.cpp

struct mapheader
{
    char magic[4];              // "OFMF"
    int version;                // any >8bit quantity is little endian
    int headersize;             // sizeof(header)
    int worldsize;
    int numpvs;
    int blendmap;
    int numvars;
    int numvslots;
};

#define WATER_AMPLITUDE 0.4f
#define WATER_OFFSET 1.1f

enum
{
    MATSURF_NOT_VISIBLE = 0,
    MATSURF_VISIBLE,
    MATSURF_EDIT_ONLY
};

/* OF */
extern int texdefscale;
#define TEX_SCALE texdefscale

struct vertex { vec pos; bvec norm; uchar reserved; vec tc; bvec4 tangent; };

