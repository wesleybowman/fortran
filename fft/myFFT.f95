subroutine myFFT(data,nn,isign)
      implicit none
      complex, dimension(:) :: data
      complex tempr, tempi
      integer nn,isign

      integer n,mmax,m,j,istep,i
      real wtemp, wr,wpr,wpi,wi,theta

      n=ishft(nn,1) !left bit shift
      j=1

    do i=1,n,2
      if(j.gt.i) then

          call SWAP(data(j),data(i))
          call SWAP(data(j+1),data(i+1))
        endif

        m=ishft(n,-1) !right bit shift
        do while(m.ge.2 .and. j.gt.m)
          j = j-m
          m = ishft(m,-1)
        enddo

        j=j+m
    enddo

    mmax=2
    do while(n.gt.mmax)
        istep=2*mmax
        theta = 6.28318530717959/(isign*mmax)
        wtemp = sin(0.5*theta)
        wpr = -2.0*wtemp*wtemp
        wpi = sin(theta)
        wr = 1.0
        wi = 0.0
        do m=1,mmax,2
            do i=m, n,istep
                j=i+mmax
                tempr=wr*data(j)-wi*data(j+1)
                tempi=wr*data(j+1)+wi*data(j)
                data(j)=data(i)-tempr
                data(j+1)=data(i+1)-tempi
                data(i)=data(i)+tempr
                data(i+1)=data(i+1)+tempi
            enddo
            wr=wr*wpr-wi*wpi+wr
            wi=wi*wpr+wtemp*wpi+wi
        enddo
    mmax=istep
    enddo

end

subroutine SWAP(a,b)
    complex a,b
    tempr=a
    a=b
    b=tempr
end
