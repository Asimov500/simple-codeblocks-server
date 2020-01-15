#include "pistache/endpoint.h"

using namespace Pistache;

class HelloHandler : public Http::Handler{
    public:
        HTTP_PROTOTYPE(HelloHandler)

        void onRequest(const Http::Request& request, Http::ResponseWriter response) override{
            UNUSED(request);
            response.send(Pistache::Http::Code::Ok, "Hello World\n");
        }
};



using namespace std;

int main(){

//Pistache Pistache;
    Pistache::Address addr(Pistache::Ipv4::any(), Pistache::Port(9080));
    auto opts = Pistache::Http::Endpoint::options()
        .threads(1);
    Http::Endpoint server(addr);
    server.init(opts);
    server.setHandler(Http::make_handler<HelloHandler>());
    server.serve();
    return 0;
}
