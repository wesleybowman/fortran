!program test
!    a = (/ 2, 3, 5, 7, 11, 13, 17 /)
!    call myfft(a)
!    contains
subroutine fft(N,in,out)
    use, intrinsic :: iso_c_binding
    include 'fftw3.f03'
    double complex :: in
    double complex, optional, intent(out):: out
    dimension in(N), out(N)
    integer*8 plan

    call dfftw_plan_dft_1d(plan,N,in,out,FFTW_FORWARD,FFTW_ESTIMATE)
    call dfftw_execute_dft(plan, in, out)
    call dfftw_destroy_plan(plan)

    return

end subroutine
!end program

subroutine fft2(M,N,in,out)
    use, intrinsic :: iso_c_binding
    include 'fftw3.f03'
    double complex in
    dimension in(M,N)
    double complex, intent(out) :: out
    dimension out(M, N)
    integer*8 plan

    call dfftw_plan_dft_2d( plan,N,M, in,out, FFTW_FORWARD, FFTW_ESTIMATE)
    call dfftw_execute_dft(plan, in, out)
    call dfftw_destroy_plan(plan)

    return
    end
