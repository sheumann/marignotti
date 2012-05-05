#include "marignotti.h"
#include <gno/kerntool.h>
#include <sys/signal.h>
#include <errno.h>


#pragma noroot
#pragma optimize 79

// called through GSOS.
int mwrite(Entry *e, void *p1, void *p2, void *p3, void *p4, void *p5)
{
    Word terr;
    Word t;
    int xerrno;
    
    char *buffer = (char *)p1;
    LongWord nbytes = *(LongWord *)p2;
    
    *(LongWord *)p2 = 0;
    
    
    // todo -- queue up if pending >= _SNDLOWAT?
    // todo -- push?
    
    IncBusy();
    terr = TCPIPWriteTCP(e->ipid, buffer, nbytes, 0, 0);
    t = _toolErr;
    DecBusy();
    if (t) terr = t;
    
    if (t || terr == tcperrBadConnection)
        return ENOTCONN;

    if (terr == tcperrNoResources)
        return ENOMEM;
    
    if (terr == tcperrConClosing)
    {
        int xerrno;
        if (!e->_NOSIGPIPE)
            Kkill(Kgetpid(), SIGPIPE, &xerrno);
            
        return EPIPE;
    }
    
    *(LongWord *)p2 = nbytes;
        
    return 0;
}