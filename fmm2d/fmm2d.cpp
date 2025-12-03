// fmm2d.cpp
#include <iostream>
#include <vector>
#include <cstdlib>
#include <chrono>
#include <random>
#include <fstream>
#include <omp.h>
//   subroutine rfmm2d(nd,eps,ns,sources,ifcharge,charge,
//  1     ifdipole,dipstr,dipvec,iper,ifpgh,pot,grad,hess,
//  2     nt,targ,ifpghtarg,pottarg,gradtarg,hesstarg,ier)

extern "C" {

    void rfmm2d_(
        // 标量
        int*    nd,          // in
        double* eps,         // in
        int*    ns,          // in
        const double* sources,   // in    shape (2, ns)
        int*    ifcharge,        // in
        const double* charge,    // in    shape (nd, ns) 或 (nd, *)
        int*    ifdipole,        // in
        const double* dipstr,    // in    shape (nd, ns) 或 (nd, *)
        const double* dipvec,    // in    shape (nd, 2, ns) 或 (nd, 2, *)
        int*    iper,            // in
        int*    ifpgh,           // in
        double* pot,             // out   shape (nd, ns)   或 (nd, *)
        double* grad,            // out   shape (nd, 2, ns)或 (nd, 2, *)
        double* hess,            // out   shape (nd, 3, ns)或 (nd, 3, *)
        int*    nt,              // in
        const double* targ,      // in    shape (2, nt)
        int*    ifpghtarg,       // in
        double* pottarg,         // out   shape (nd, nt)   或 (nd, *)
        double* gradtarg,        // out   shape (nd, 2, nt)或 (nd, 2, *)
        double* hesstarg,        // out   shape (nd, 3, nt)或 (nd, 3, *)
        int*    ier              // out
    );
    
} // extern "C"

int main(int argc, char** argv) {
    if (argc != 2){
        std::cerr << "Usage: " << argv[0] << " <output_file>\n";
        return 1;
    }

    std::string output_file = argv[1];

    int nd = 1;
    double eps = 1e-4;
    int nt = 0;
    int ifcharge = 1, ifdipole = 0, iper = 0, ifpgh = 2, ifpghtarg = 0;
    int ier = 0;

    std::vector<double> sources, charge, pot, grad;

    std::ofstream fout(output_file);
    fout << "ns,num_thread,elapsed\n";

    int n_trials = 10;

    for (int ns = 100; ns <= 500000; ns *= 2){
        sources.resize(2*ns);
        charge.resize(nd*ns);
        pot.resize(nd*ns);
        grad.resize(nd*2*ns);

        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_real_distribution<> dis(0.0, 1.0);

        for (int i = 0; i < ns; ++i){
            sources[2*i] = dis(gen);
            sources[2*i+1] = dis(gen);
            charge[i] = dis(gen);
        }

        auto start = std::chrono::high_resolution_clock::now();

        for (int trial = 0; trial < n_trials; ++trial){
            rfmm2d_(&nd, &eps, &ns, sources.data(),
                    &ifcharge, charge.data(),
                    &ifdipole, nullptr, nullptr,
                    &iper, &ifpgh, pot.data(), grad.data(), nullptr,
                    &nt, nullptr, &ifpghtarg,
                    nullptr, nullptr, nullptr, &ier);
        }

        auto end = std::chrono::high_resolution_clock::now();
        double elapsed = std::chrono::duration<double>(end - start).count() / n_trials;

        std::cout << "ns: " << ns << ", elapsed: " << elapsed << " s\n";
        fout << ns << "," << omp_get_max_threads() << "," << elapsed << "\n";
    }

    fout.close();

    return 0;
}
