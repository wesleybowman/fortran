subroutine test(k,l,data)
  use fft_mod
  implicit none
  complex(kind=dp), intent(inout) :: data(k,l)
  integer k,l,i,j
  print*, dp

!  do i=1, k
!    do j=1, l
!  call fft(data(k,l))
!    enddo
!  enddo

  do i=1, 8
     write(*,'("(", F20.15, ",", F20.15, "i )")') data
  end do

end subroutine test
