subroutine holoPy(x)
    implicit none
    real, parameter :: pi=3.141592653589793238460
      complex, dimension(:) :: x
      call fft(x)

end

recursive subroutine fft(x,y)
    !integer,       parameter :: dp=selected_real_kind(15,300)

    complex, dimension(:), intent(in)   :: x
    complex, dimension(:), optional, intent(out)  :: y
    complex                               :: t
    integer                                        :: N
    integer                                        :: i
    complex, dimension(:), allocatable    :: even, odd

    N=size(x)

    !if(N .le. 1) return

    allocate(odd((N+1)/2))
    allocate(even(N/2))

    ! divide
    odd =x(1:N:2)
    even=x(2:N:2)
    print*,odd,even

    ! conquer
    call fft(odd)
    call fft(even)
!
!    ! combine
!    do i=1,N/2
!
!
!    t=exp(cmplx(0.0_dp,-2.0_dp*pi*real(i-1,dp)/real(N,dp),KIND=DP))*even(i)
!    x(i)     = odd(i) + t
!    x(i+N/2) = odd(i) - t
!    end do
!
!    deallocate(odd)
!    deallocate(even)
    end subroutine fft



