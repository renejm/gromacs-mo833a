/*
 * This file is part of the GROMACS molecular simulation package.
 *
 * Copyright (c) 2019, by the GROMACS development team, led by
 * Mark Abraham, David van der Spoel, Berk Hess, and Erik Lindahl,
 * and including many others, as listed in the AUTHORS file in the
 * top-level source directory and at http://www.gromacs.org.
 *
 * GROMACS is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 2.1
 * of the License, or (at your option) any later version.
 *
 * GROMACS is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with GROMACS; if not, see
 * http://www.gnu.org/licenses, or write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA.
 *
 * If you want to redistribute modifications to GROMACS, please
 * consider that scientific software is very special. Version
 * control is crucial - bugs must be traceable. We will be happy to
 * consider code for inclusion in the official distribution, but
 * derived work must not be called official GROMACS. Details are found
 * in the README & COPYING files - if they are missing, get the
 * official version at http://www.gromacs.org.
 *
 * To help us fund GROMACS development, we humbly ask that you cite
 * the research papers on the package. Check out http://www.gromacs.org.
 */
/*! \libinternal \file
 *
 * \brief Declarations for CUDA implementation of Leap-Frog.
 *
 * \todo Reconsider naming towards using "gpu" suffix instead of "cuda".
 *
 * \author Artem Zhmurov <zhmurov@gmail.com>
 *
 * \ingroup module_mdlib
 * \inlibraryapi
 */
#ifndef GMX_MDLIB_LEAPFROG_CUDA_CUH
#define GMX_MDLIB_LEAPFROG_CUDA_CUH

#include "gromacs/mdtypes/mdatom.h"
#include "gromacs/pbcutil/pbc.h"
#include "gromacs/pbcutil/pbc_aiuc.h"
#include "gromacs/utility/classhelpers.h"

namespace gmx
{

class LeapFrogCuda
{

    public:

        LeapFrogCuda();
        ~LeapFrogCuda();

        /*! \brief
         * Update PBC data.
         *
         * Converts PBC data from t_pbc into the PbcAiuc format and stores the latter.
         *
         * \param[in] pbc The PBC data in t_pbc format.
         */
        void setPbc(const t_pbc *pbc);

        /*! \brief Set the integrator
         *
         * Copies inverse masses from CPU to GPU.
         *
         * \param[in] md    MD atoms, from which inverse masses are taken.
         */
        void set(const t_mdatoms &md);

        /*! \brief Integrate
         *
         * Integrates the equation of motion using Leap-Frog algorithm.
         * Updates coordinates and velocities on the GPU.
         *
         * \param[in]     d_x   Initial coordinates.
         * \param[out]    d_xp  Place to save the resulting coordinates to.
         * \param[in,out] d_v   Velocities (will be updated).
         * \param[in]     d_f   Forces.
         * \param[in]     dt    Timestep.
         */
        void integrate(const float3 *d_x,
                       float3       *d_xp,
                       float3       *d_v,
                       const float3 *d_f,
                       const real    dt);

    private:

        //! CUDA stream
        cudaStream_t stream_;
        //! Periodic boundary data
        PbcAiuc      pbcAiuc_;
        //! Number of atoms
        int          numAtoms_;

        //! 1/mass for all atoms (GPU)
        real        *d_inverseMasses_;

};

} //namespace gmx

#endif