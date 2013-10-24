subroutine trans_func(x,y,m,xx,yy,n,xxx,yyy,zzz,d,wavelen,root,newroot,g)
    implicit none
    real, parameter :: pi=3.141592653589793238460

    integer x,y,xx,yy,xxx,yyy,zzz
    real m(x,y),n(xx,yy), nn(xx,yy), mm(x,y)
    real, dimension(x,yy), intent(out) :: root
    real d(xxx,yyy,zzz)
    real wavelen

    integer i,j
    complex, dimension(x,yy), intent(out) :: newroot
    complex, dimension(x,yy,zzz), intent(out) :: g
    complex jj


!    print*, shape(m)
!    print*, shape(n)
!    print*, shape(d)
!    nn= transpose(n)
!    print*, shape(nn)

    mm = (wavelen*m)*(wavelen*m)
    nn = (wavelen*n)*(wavelen*n)


!    print*, 'mm,nn'
!    print*, shape(mm)
!    print*, shape(nn)

    do j=1,yy
        do i=1,x
            root(j,i) =  1 - nn(1,j) - mm(i,1)
        enddo
    enddo


    where (root .ge. 0)
        root = root !* root
    elsewhere
        root = 0
    endwhere

    jj = cmplx(0,1)

    newroot = cmplx(root,0)

    do i=1, zzz
        !g(:,:,i) = (-1*jj*2*pi*d(1,1,i)/wavelen)*sqrt(newroot)

        g(:,:,i) = exp((-1*jj*2*pi*d(1,1,i)/wavelen)*sqrt(newroot))

        !print*, g(:,:,i)
    enddo

    !g = exp(g)

    !g = (-1*jj*2*pi*d/wavelen)*sqrt(root)


    return
end


subroutine faster_trans_func(x,y,m,xx,yy,n,xxx,yyy,zzz,d,wavelen,g)
    implicit none
    real, parameter :: pi=3.141592653589793238460

    integer x,y,xx,yy,xxx,yyy,zzz
    real m(x,y),n(xx,yy), nn(xx,yy), mm(x,y)
    real, dimension(x,yy) :: root
    real d(xxx,yyy,zzz)
    real wavelen

    integer i,j
    complex, dimension(x,yy) :: newroot
    complex, dimension(x,yy,zzz), intent(out) :: g
    complex jj
    !integer*8 t1,t2,t3,t4

    mm = (wavelen*m)*(wavelen*m)
    nn = (wavelen*n)*(wavelen*n)

    !call system_clock(t1)

    do j=1,yy
        do i=1,x
            root(j,i) =  1 - nn(1,j) - mm(i,1)
        enddo
    enddo

    !call system_clock(t2)

    where (root .lt. 0)
        root = 0
    endwhere

    !call system_clock(t3)

    jj = cmplx(0,1)

    newroot = cmplx(root,0)
    newroot = sqrt(newroot)

    do i=1, zzz
        g(:,:,i) = (-1*jj*2*pi*d(1,1,i)/wavelen)*newroot
    enddo

    !call system_clock(t4)

    !where (root .ge. 0)
        !g = exp(g)*root

    return
end


subroutine test(xxx,yyy,zzz,d,wavelen,x,y,root,newroot,g)
    implicit none
    real, parameter :: pi=3.141592653589793238460

    integer x,y,xxx,yyy,zzz
    complex, dimension(x,y) :: root
    real d(xxx,yyy,zzz)
    real wavelen

    integer i
    complex, dimension(x,y), intent(out) :: newroot
    complex, dimension(x,y,zzz), intent(out) :: g
    complex jj

    jj = cmplx(0,1)

    !newroot = cmplx(root,0)
    newroot = sqrt(root)
    !newroot = sqrt(newroot)

    do i=1, zzz
        g(:,:,i) = (-1*jj*2*pi*d(1,1,i)/wavelen)*newroot
    enddo

    g = exp(g)

    return
end




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
