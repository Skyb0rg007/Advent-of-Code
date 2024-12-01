! vim: set ft=fortran ts=2 sw=2:

program hello
  implicit none

  interface
    subroutine compute(nums)
      integer, intent(inout) :: nums(:, :)
    end subroutine compute
  end interface

  integer :: io, stat
  character(len=512) :: msg
  character(len=80) :: filename
  character(len=200) :: line

  integer :: nums(20, 20)
  integer :: n = 6

  integer :: i
  integer :: sum

  do i = 1, 20
    nums(i, :) = 0
  end do

  call get_command_argument(1, filename)
  open(newunit=io, file=filename, status="old", action="read", &
    iostat=stat, iomsg=msg)
  if (stat /= 0) then
    print *, trim(msg)
    return
  end if

  sum = 0
  do
    read (io, '(a)', iostat=stat, iomsg=msg) line
    if (stat /= 0) exit

    print *, 'line: "', trim(line), '"'

    read (line, *, iostat=stat, iomsg=msg) nums(1, 1:n-1)
    if (stat /= 0) then
      print *, trim(msg)
      return
    end if

    do i = 1, n
      print *, nums(i, 1:n-i)
    end do
    call compute(nums)
    sum = sum + nums(1, n)
    do i = 1, n
      print *, nums(i, 1:n-i+1)
    end do
  end do
  print *, 'Part 1: ', sum

  close(io)
end program hello

subroutine compute(nums)
  implicit none
  integer, intent(inout) :: nums(:, :)
  integer :: i, j
  integer :: n = 6

  do i = 1, n-1
    do j = 1, n-1 - i
      nums(i + 1, j) = nums(i, j + 1) - nums(i, j)
    end do
  end do

  ! do j = 2, n
  !   i = n - j
  !   nums(i, j) = 
  ! end do
  do i = n - 1, 1, -1
    j = n - i
    nums(i, j + 1) = nums(i, j) + nums(i + 1, j)
  end do
end subroutine compute
