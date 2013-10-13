subroutine add(a)
    real :: a
    b=2*a
    print*, b
    return
end subroutine add

subroutine fcumsum(a, b, n)
    real a(n), b(n)
    integer :: n
    intent(in) :: a
    intent(out) :: b

    b(1)=a(1)

    do 100 i=2, n

    b(i) = b(i-1) + a(i)

    100 continue

    return
end subroutine fcumsum

subroutine matrix(n, m, a,b)
    !real, dimension(3,3) :: a
    integer m,n
    real, intent(in) :: a(m,n)
    real, intent(out) :: b(m,n)

    do i=1, 3
        do j=1, 3
            b(i,j)=a(i,j)*2
        enddo
        enddo

    return

end subroutine matrix

subroutine tdmatrix(k, l, m, a, b)
    !real, dimension(3,3) :: a
    integer k,l,m,x,y,z
    real a(k, l, m)
    real, intent(out) :: b(k, l, m)

    do x=1, 3
        do y=1, 3
            do z=1, 3
                b(x,y,z)=a(x,y,z)*2
                enddo
        enddo
    enddo

    return
end

subroutine bitshift()
    implicit none
    integer x,y,z
    x=4
    y=ishft(x,1) !Left bitshift
    z=ishft(x,-1) !Left bitshift
    print*,y,z
end

program main
    call bitshift()
end
